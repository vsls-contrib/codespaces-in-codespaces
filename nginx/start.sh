#!/bin/bash

CONTAINER_NAME=codespaces-nginx

mkdir ./ssl

echo -e "\n* Installing the root CA..\n"

mkcertBin=./bin/mkcert-linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    mkcertBin=./bin/mkcert-darwin
fi

sudo $mkcertBin -install

echo -e "\n* Creating certs..\n"

$mkcertBin -cert-file ./ssl/cert.pem -key-file ./ssl/key.pem github.localhost '*.github.localhost'

# start container
docker_state=$(docker info >/dev/null 2>&1)
if [[ $? -ne 0 ]]; then
    echo -e "\n** Docker is not running, please start docker deamon first."
    exit 1
fi

# docker is running

echo -e "* Starting nginx as $CONTAINER_NAME..\n"

docker rm -f $CONTAINER_NAME &> /dev/null

docker run --name $CONTAINER_NAME -p 443:443 -v $(pwd):/etc/nginx:ro -d nginx

if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo -e "! Could not start the DNS server docker container, terminating.."
    exit 1
fi

echo -e "\n* Done."
