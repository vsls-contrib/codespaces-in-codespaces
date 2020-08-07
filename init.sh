#!/bin/bash

clear

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

echo -e $PALETTE_PURPLE"\n🏃 Lets setup the Codesace"$PALETTE_RESET

sleep 0.25s

echo -e $PALETTE_CYAN"\n- Please provide your AzDO username\n"$PALETTE_RESET

read -p " ↳ AzDO Username: " AZ_DO_USERNAME_INPUT
echo ""

if [ -z ${AZ_DO_USERNAME_INPUT} ]; then
    echo -e $PALETTE_RED"  🗿 No name - no fame"$PALETTE_RESET
    exit 1
fi

IFS=@ read -r username domain <<< "$AZ_DO_USERNAME_INPUT"

if [ ! -z "$domain" ]; then
    AZ_DO_USERNAME_INPUT="$username"
    echo -e $PALETTE_LIGHT_GRAY"  * using *$AZ_DO_USERNAME_INPUT* as AzDO username. "$PALETTE_RESET
fi

export AZ_DO_USERNAME=$AZ_DO_USERNAME_INPUT

echo "
export AZ_DO_USERNAME=$AZ_DO_USERNAME
" >> ~/.bashrc

echo -e $PALETTE_CYAN"\n- Thanks, *$AZ_DO_USERNAME*! Please provide your AzDO PAT\n"$PALETTE_RESET


unset AZ_DO_PAT_INPUT
prompt=" ↳ PAT (code[R/W] + packaging[R]): $PALETTE_LIGHTGRAY"
while IFS= read -p "$prompt" -r -s -n 1 char
do
    if [[ $char == $'\0' ]]
    then
        break
    fi
    prompt='*'
    AZ_DO_PAT_INPUT+="$char"
done

echo -e " "$PALETTE_RESET

if [ -z ${AZ_DO_PAT_INPUT} ]; then
    echo -e $PALETTE_RED"  🐢 No PAT - Zero FLOPS per watt"$PALETTE_RESET
    exit 1
fi

export AZ_DO_PAT=$AZ_DO_PAT_INPUT
export AZ_DO_PAT_BASE64=$(echo -n $AZ_DO_PAT | base64)

echo "
export AZ_DO_PAT=$AZ_DO_PAT
export AZ_DO_PAT_BASE64=$AZ_DO_PAT_BASE64
" >> ~/.bashrc

git remote add azdo https://$AZ_DO_USERNAME:$AZ_DO_PAT@devdiv.visualstudio.com/OnlineServices/_git/vsclk-core

echo -e $PALETTE_LIGHT_YELLOW"\n ⌬ Fetching the repo\n"$PALETTE_RESET

git reset --hard
git branch --track github-main

# clone the AzDO repo
git pull azdo master:main --force --no-tags

# setup NuGet feeds
FEED_NAME="vssaas-sdk"
dotnet nuget remove source $FEED_NAME
dotnet nuget add source "https://devdiv.pkgs.visualstudio.com/_packaging/vssaas-sdk/nuget/v3/index.json" -n $FEED_NAME -u "devdiv" -p "$AZ_DO_PAT" --store-password-in-clear-text

FEED_NAME="Cascade"
dotnet nuget remove source $FEED_NAME
dotnet nuget add source "https://devdiv.pkgs.visualstudio.com/_packaging/Cascade/nuget/v3/index.json" -n $FEED_NAME -u "devdiv" -p "$AZ_DO_PAT" --store-password-in-clear-text

# go to `Website`
cd $CSCLIENT
# initialize the codespace
yarn setup:codespace
# go to `Website`
cd $CSCLIENT

exec bash
