source ./app/src/controller/data.sh

installGit(){
    if [ -x "$(command -v git)" ]; then
        echo "Git is already installed"
    else
        echo "Git is not installed"
        echo "Do you want to install git ? [y/n]"
        read response
        if [ $response == "y" ]; then
            sudo apt update
            sudo apt upgrade
            sudo apt install git
        else
            echo "Git is required to run this script"
            exit 1
        fi
    fi
}

installXdg(){
    if [ ! -x "$(command -v xdg-open)" ]; then
        echo "xdg-open is not installed"
        echo "Do you want to install xdg-open ? [y/n]"
        read response
        if [ $response == "y" ]; then
            sudo apt install xdg-utils
        else
            echo "xdg-open is required to run this script"
            exit 1
        fi
    fi
}



configGithub(){
    if [ ! $(cat ./app/src/data/name.bin) ]; then
        echo "Enter your GitHub name: "
        read -r name
        export NAME="$name"
        save_data "$name" "./app/src/data/name.bin"
    fi

    if [ ! $(cat ./app/src/data/email.bin) ]; then
        echo "Enter your GitHub email: "
        read -r email
        export EMAIL="$email"
        save_data "$email" "./app/src/data/email.bin"
    fi
}

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

sshConnectGithub(){
    if [ ! $(cat ./app/src/data/token.bin) ]; then
        echo "Generate ssh key"
        ssh-keygen -t rsa -b 4096 -C $EMAIL
        clear
        echo -e "${RED}please copy the key above and add this key to your github account!${NC}"
        echo -e ""
        cat /home/$USERNAME/.ssh/id_rsa.pub
        echo -e ""
        xdg-open https://github.com/settings/keys >/dev/null 2>&1 &
        echo "Do you add your ssh-key to your github account ? [y/n]"
        read response
        if [ $response == "y" ]; then     
            echo ""
            echo -e "${GREEN}Please generate a token and copy it !${NC}"
            echo ""
            xdg-open https://github.com/settings/tokens >/dev/null 2>&1 &
            echo ""
            read -p "Enter your token : " token
            save_data "$token" "./app/src/data/token.bin"
        else
            echo "Connection failed"
        fi
    fi

}

remoteGithub(){
    git config --global user.name "$(cat ./app/src/data/name.bin)"
    git config --global user.email "$(cat ./app/src/data/email.bin)"

    NAME="$(cat ./app/src/data/name.bin)"
    TOKEN="$(cat ./app/src/data/token.bin)"

    cd /home/$USERNAME/Downloads/test
    touch README.md
    echo "# ${PWD##*/} : last update $(date)" > README.md
    # mkdir /home/$USER/Desktop/test
    git config --global init.defaultBranch main
    # Set up Git configuration to use the access token
    git config --global credential.helper store
    echo -e "https://$NAME:$TOKEN@github.com" > ~/.git-credentials

    git init
    git remote -v
    # git remote add origin "https://$TOKEN@github.com/$NAME/${PWD##*/}"
}

pushToGithub(){
    remoteGithub
    git add README.md *.crypt
    git commit -m "Update at $(date +'%d-%m-%Y %H:%M:%S')"
    git push -u origin main --force
}
