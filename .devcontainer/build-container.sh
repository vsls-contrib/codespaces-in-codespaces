#!/bin/bash
set -ex

BASE_IMAGE="ghcr.io/vsls-contrib/codespaces-in-codespaces:main"
DOCKER_ID=nightly
TARGET_IMAGE="docker.pkg.github.com/github/github/${DOCKER_ID}:latest"

docker pull $BASE_IMAGE

docker rm -f $DOCKER_ID 2> /dev/null || true

echo "https://git:$GITHUB_TOKEN@github.com" > git-credentials
trap "rm -f git-credentials" EXIT

docker run --name $DOCKER_ID \
    --privileged --detach \
    -v $PWD:/root/workspace/github \
    -v ${PWD}/git-credentials:/root/.git-credentials \
    $BASE_IMAGE

SETUP_SCRIPT='
    git config --global credential.helper store
    git config --global url."https://github.com/".insteadOf git@github.com:
    # Wait for mysql startup
    sleep 5s
    # Convert mysql root user to password auth instead of socket
    mysql -u root -e "ALTER USER \"root\"@\"localhost\" IDENTIFIED WITH mysql_native_password BY \"\""
    # Apply our mysql dev config
    cp --force ./config/my.cnf.dev /etc/mysql/my.cnf
    supervisorctl restart mysql
    # Needed for nginx conf generation
    script/build-subproject homebrew-bootstrap
    script/bootstrap --local
    script/setup --force
    # Install generated nginx conf
    rm -f /etc/nginx/sites-enabled/default
    ln -s $PWD/config/dev/nginx.root.conf /etc/nginx/sites-enabled/github.conf
    # Save vendor directory for devcontainer
    tar -czf /root/vendor.tar.gz vendor
    git config --global --unset credential.helper
'

docker exec --workdir /root/workspace/github $DOCKER_ID bash -c "$SETUP_SCRIPT"

# Kill running container, commit result as the target, delete the temp container
docker kill $DOCKER_ID
docker commit $DOCKER_ID $TARGET_IMAGE
docker rm -f $DOCKER_ID

# Codespace creation will fail if workdir exists, so run the image we just 
# created, cleanup mount points, and commit the result as the target again.
docker run --name $DOCKER_ID --privileged --detach $TARGET_IMAGE
docker exec $DOCKER_ID rm -r /root/workspace/github /root/.git-credentials
docker kill $DOCKER_ID
docker commit $DOCKER_ID $TARGET_IMAGE
docker rm -f $DOCKER_ID