#!/bin/bash

hello_world() {
    read -p "Enter your name : " name
    echo "Hello, $name!"
}

run(){
    echo "Welcome in BackupLik"
}

installGit(){
    if [ -x "$(command -v git)" ]; then
        echo "Git is already installed"
    else
        echo "Git is not installed"
        echo "Do you want to install git ? (y/n)"
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

    if [ ! -x "$(command -v xdg-open)" ]; then
        echo "xdg-open is not installed"
        echo "Do you want to install xdg-open ? (y/n)"
        read response
        if [ $response == "y" ]; then
            sudo apt install xdg-utils
        else
            echo "xdg-open is required to run this script"
            exit 1
        fi
    fi

    echo "Entre your github name : "
    read name

    echo "Entre your github mail : "
    read mail

    git config --global user.name $name
    git config --global user.email $mail

    echo "Git is installed"
    echo `git config --global --list`
}

sshConnect(){
    echo "Generate ssh key"
    echo "Entre your github mail : "
    read email
    ssh-keygen -t rsa -b 4096 -C $email
    cat /$USER/.ssh/id_rsa.pub
    echo "Add this key to your github account"
    xdg-open https://github.com/settings/keys

    echo "Entre your github ssh key: "      
    xdg-open https://github.com/settings/tokens
    read key

    git init
    git remote -v

}

fileBackup(){
    echo "Entre Path of file : " #path relatif / absolute
    read path
}

connectToGithub(){
    git config --global user.name name
    git config --global user.email email

    echo "Entre your github ssh key: "
    read key
    
    git init
    git remote -v

}

# hello_world
# installGit
sshConnect