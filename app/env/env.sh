#!/bin/bash

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
    if [ ! $USERNAME ]; then
        echo "Entre your github name : "
        read name
        export USERNAME="$name"
    fi

    if [ ! $EMAIL ]; then
        echo "Entre your github email : "
        read email
        export EMAIL="$email"
    fi

    git config --global user.name $USERNAME
    git config --global user.email $EMAIL

    echo "Git Config : "
    echo `git config --global --list`
}

sshConnectGithub(){
    echo "Generate ssh key"
    ssh-keygen -t rsa -b 4096 -C $EMAIL
    cat /home/$USER/.ssh/id_rsa.pub
    echo "Add this key to your github account"
    xdg-open https://github.com/settings/keys

    echo "Do you add your key to your github account ? [y/n]"
    read response
    if [ $response == "y" ]; then
        echo "Connection established"
        echo "Entre your github ssh key: "      
        xdg-open https://github.com/settings/tokens
    else
        echo "Connection failed"
    fi
}

pushToGithub(){
    echo "Do you add your generated token to your github account ? [y/n]"
    read result
    if [ $result == "y" ]; then
        read -p "Enter your token : " token
        git init
        git add .
        git commit -m "Create project"
        git branch -M main
        git remote set-url origin "https://$token@github.com/$NAME/${PWD##*/}"
        git push -u origin main
    else
        echo "Connection failed"
    fi
}


run(){
    echo "Welcome in BackupLik"
    installGit
    installXdg
    configGithub
}

run