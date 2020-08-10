export NODE_VERSION=12.18.1
# install NodeJS
curl -sL https://deb.nodesource.com/setup_12.x -o ~/nodesource_setup.sh && bash ~/nodesource_setup.sh && apt install nodejs -y
# install yarn
npm i -g yarn

# install Azure Credentials Provider for NuGet
wget -c https://github.com/microsoft/artifacts-credprovider/releases/download/v0.1.22/Microsoft.NuGet.CredentialProvider.tar.gz -O - | tar -xz -C ~/.nuget

# add oh-my-bash
wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O - | sh -C

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

# add .bashrc config
echo "
# workspace
export CODESPACE_ROOT=$(pwd)
export CSCLIENT=\"\$CODESPACE_ROOT/src/Portal/PortalWebsite/Src/Website\"
export CSSERVER=\"\$CODESPACE_ROOT/src/services/containers/VsClk.Portal.WebSite\"
alias cdroot='cd \$CODESPACE_ROOT'
alias cdclient='cd \$CSCLIENT'
alias cdserver='cd \$CSSERVER'
alias codespaces:setup='bash ./init.sh && cdclient && exec bash'
# misc
alias code='code-insiders'
alias ls='ls --color=auto \$@'
alias ww='watch -n 1 \"date && echo -e \ &&\$@\"'
alias do='dotnet\$@'
alias refresh='exec bash'
# git
alias push='git push -u origin HEAD'
alias pull='git pull'
alias fetch='git fetch origin'
alias pullmaster='git pull origin master'
alias branch='f() { git checkout master && git pull origin master && git checkout -b dev/\$AZ_DO_USERNAME_INPUT/\$@ };f'

## Color variables

# Dimmed text
export PALETTE_DIM='\e[2m'

# Bold Text
export PALETTE_BOLD='\e[1m'

# Underlined Text
export PALETTE_UNDERLINED='\e[4m'

# Blinking
export PALETTE_BLINK='\e[5m'

# Reverse
export PALETTE_REVERSE='\e[7m'

# Foreground Color
export PALETTE_BLACK='\e[30m'
export PALETTE_WHITE='\e[97m'
export PALETTE_RED='\e[31m'
export PALETTE_GREEN='\e[32m'
export PALETTE_BROWN='\e[33m'
export PALETTE_BLUE='\e[34m'
export PALETTE_PURPLE='\e[35m'
export PALETTE_CYAN='\e[36m'
export PALETTE_LIGHTGRAY='\e[37m'
export PALETTE_LIGHT_YELLOW='\e[93m'

# Background Color
export PALETTE_BLACK_U='\e[40m'
export PALETTE_RED_U='\e[41m'
export PALETTE_GREEN_U='\e[42m'
export PALETTE_BROWN_U='\e[43m'
export PALETTE_BLUE_U='\e[44m'
export PALETTE_PURPLE_U='\e[45m'
export PALETTE_CYAN_U='\e[46m'
export PALETTE_LIGHTGRAY_U='\e[47m'

# Normal Text
export PALETTE_RESET='\e[0m'

cd \$CSCLIENT
" >> ~/.bashrc

exec bash
