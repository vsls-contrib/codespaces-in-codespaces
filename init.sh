#!/bin/bash

clear

# Normal Text
export PALETTE_RESET='\e[0m'

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
export PALETTE_WHITE="\e[97m"
export PALETTE_RED='\e[31m'
export PALETTE_GREEN='\e[32m'
export PALETTE_BROWN='\e[33m'
export PALETTE_BLUE='\e[34m'
export PALETTE_PURPLE='\e[35m'
export PALETTE_CYAN='\e[36m'
export PALETTE_LIGHTGRAY='\e[37m'
export PALETTE_LIGHT_YELLOW="\e[93m"

# Background Color
export PALETTE_BLACK_U='\e[40m'
export PALETTE_RED_U='\e[41m'
export PALETTE_GREEN_U='\e[42m'
export PALETTE_BROWN_U='\e[43m'
export PALETTE_BLUE_U='\e[44m'
export PALETTE_PURPLE_U='\e[45m'
export PALETTE_CYAN_U='\e[46m'
export PALETTE_LIGHTGRAY_U='\e[47m'

GREETINGS=("Bonjour" "Hello" "Salam" "Привет" "Вітаю" "Hola" "Zdravo" "Ciao" "Salut" "Hallo" "Nǐ hǎo" "Xin chào" "Yeoboseyo" "Aloha" "Namaskaram" "Wannakam" "Dzień dobry")
GREETING=${GREETINGS[$RANDOM % ${#GREETINGS[@]} ]}

echo -e $PALETTE_WHITE"\n
        ~+

                 *       +
           '                  |
         +   .-.,=\"\`\`\"=.    - o -
             '=/_       \     |
          *   |  '=._    |   
               \     \`=./\`,        '
            .   '=.__.=' \`='      *
   +                         +
        O      *        '       .
"$PALETTE_RESET

echo -e $PALETTE_GREEN"\n\n     🖖 👽  $GREETING, Codespacer 👽 🖖\n"$PALETTE_RESET

sleep 1s

echo -e $PALETTE_LIGHT_YELLOW"\n\n     Lets setup the Git repo  \n"$PALETTE_RESET

sleep 1s

echo -e $PALETTE_CYAN"\n- Please provide your AzDO username\n"$PALETTE_RESET

read -p " ↳ Username: " AZ_DO_USERNAME_INPUT
echo ""

if [ -z ${AZ_DO_USERNAME_INPUT} ]; then
    echo -e $PALETTE_RED"\n   🗿No name - no fame"$PALETTE_RESET
    exit 1
fi

export AZ_DO_USERNAME=$AZ_DO_USERNAME_INPUT

echo "
export AZ_DO_USERNAME=$AZ_DO_USERNAME
" >> ~/.npmrc

echo -e $PALETTE_CYAN"\n- Thanks, *$AZ_DO_USERNAME*! Please provide your AzDO PAT\n"$PALETTE_RESET

stty_orig=$(stty -g)
stty -echo
read -p " ↳ PAT: " AZ_DO_PAT_INPUT
stty $stty_orig
echo ""

if [ -z ${AZ_DO_PAT_INPUT} ]; then
    echo -e $PALETTE_RED"\n   🐢No PAT - Zero FLOPS per watt"$PALETTE_RESET
    exit 1
fi

export AZ_DO_PAT=$AZ_DO_PAT_INPUT
export AZ_DO_PATH_BASE64=`echo '$AZ_DO_PAT' | base64`

echo "
export AZ_DO_PAT=$AZ_DO_PAT
AZ_DO_PATH_BASE64=$AZ_DO_PATH_BASE64
" >> ~/.npmrc

git remote add azdo https://$AZ_DO_USERNAME:$AZ_DO_PAT@devdiv.visualstudio.com/OnlineServices/_git/codespaces-in-codespaces

echo -e $PALETTE_LIGHT_YELLOW"\n ⌬ Fetching the repo\n"$PALETTE_RESET

export VSCS_SETUP_PREVENT_WEBSITE_GREETING='true'

git pull azdo master:master --force

# go to `Website`
cd $CSCLIENT

# initialzie the codespace
yarn setup:codespace


