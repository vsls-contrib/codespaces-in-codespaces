export NODE_VERSION=12.18.1
# install NodeJS
curl -sL https://deb.nodesource.com/setup_12.x -o ~/nodesource_setup.sh && bash ~/nodesource_setup.sh && apt install nodejs -y
# install yarn
npm i -g yarn

# install Azure Credentials Provider for NuGet
wget -c https://github.com/microsoft/artifacts-credprovider/releases/download/v0.1.22/Microsoft.NuGet.CredentialProvider.tar.gz -O - | tar -xz -C ~/.nuget

# add oh-my-bash
wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O - | sh -C

WORKSPACE_ROOT='/root/workspace/codespaces-in-codespaces'

# add .bashrc config
echo "export CSCLIENT='$WORKSPACE_ROOT/src/Portal/PortalWebsite/Src/Website'\nexport CSSERVER='$WORKSPACE_ROOT/src/services/containers/VsClk.Portal.WebSite'\nalias cdclient='cd \$CSCLIENT'\nalias cdserver='cd \$CSSERVER'\nalias code='code-insiders'\nalias ls='ls --color=auto'" >> ~/.bashrc

exec bash
