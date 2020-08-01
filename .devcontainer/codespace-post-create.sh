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

# connect AzDO `npm` feeds
echo "
; begin auth token
//devdiv.pkgs.visualstudio.com/_packaging/VS/npm/registry/:username=devdiv
//devdiv.pkgs.visualstudio.com/_packaging/VS/npm/registry/:_password=\${AZ_DO_PAT_BASE64}
//devdiv.pkgs.visualstudio.com/_packaging/VS/npm/registry/:email=npm requires email to be set but doesn't use the value
//devdiv.pkgs.visualstudio.com/_packaging/VS/npm/:username=devdiv
//devdiv.pkgs.visualstudio.com/_packaging/VS/npm/:_password=\${AZ_DO_PAT_BASE64}
//devdiv.pkgs.visualstudio.com/_packaging/VS/npm/:email=npm requires email to be set but doesn't use the value
; end auth token

; begin auth token
//devdiv.pkgs.visualstudio.com/_packaging/NodeRepos/npm/registry/:username=devdiv
//devdiv.pkgs.visualstudio.com/_packaging/NodeRepos/npm/registry/:_password=\${AZ_DO_PAT_BASE64}
//devdiv.pkgs.visualstudio.com/_packaging/NodeRepos/npm/registry/:email=npm requires email to be set but doesn't use the value
//devdiv.pkgs.visualstudio.com/_packaging/NodeRepos/npm/:username=devdiv
//devdiv.pkgs.visualstudio.com/_packaging/NodeRepos/npm/:_password=\${AZ_DO_PAT_BASE64}
//devdiv.pkgs.visualstudio.com/_packaging/NodeRepos/npm/:email=npm requires email to be set but doesn't use the value
; end auth token

; begin auth token
//devdiv.pkgs.visualstudio.com/_packaging/Cascade/npm/registry/:username=devdiv
//devdiv.pkgs.visualstudio.com/_packaging/Cascade/npm/registry/:_password=\${AZ_DO_PAT_BASE64}
//devdiv.pkgs.visualstudio.com/_packaging/Cascade/npm/registry/:email=npm requires email to be set but doesn't use the value
//devdiv.pkgs.visualstudio.com/_packaging/Cascade/npm/:username=devdiv
//devdiv.pkgs.visualstudio.com/_packaging/Cascade/npm/:_password=\${AZ_DO_PAT_BASE64}
//devdiv.pkgs.visualstudio.com/_packaging/Cascade/npm/:email=npm requires email to be set but doesn't use the value
; end auth token

; begin auth token
//devdiv.pkgs.visualstudio.com/DevDiv/_packaging/playwright/npm/registry/:username=devdiv
//devdiv.pkgs.visualstudio.com/DevDiv/_packaging/playwright/npm/registry/:_password=\${AZ_DO_PAT_BASE64}
//devdiv.pkgs.visualstudio.com/DevDiv/_packaging/playwright/npm/registry/:email=npm requires email to be set but doesn't use the value
//devdiv.pkgs.visualstudio.com/DevDiv/_packaging/playwright/npm/:username=devdiv
//devdiv.pkgs.visualstudio.com/DevDiv/_packaging/playwright/npm/:_password=\${AZ_DO_PAT_BASE64}
//devdiv.pkgs.visualstudio.com/DevDiv/_packaging/playwright/npm/:email=npm requires email to be set but doesn't use the value
; end auth token
" >> ~/.npmrc

exec bash
