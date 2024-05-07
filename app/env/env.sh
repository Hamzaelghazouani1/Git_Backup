#!/bin/bash

function hello_world(name) {
  echo "Hello, $name!"
}

function run(){
    echo "Welcome in BackupLik"
}

function installGit(){
    sudo apt update
    sudo apt install git

    echo "Entre your github name : "
    read name

    echo "Entre your github mail : "
    read mail

    ssh-keygen -t rsa -b 4096 -C email
    cd /home/$USER/.ssh 
}

function fileBackup(){
    echo "Entre Path of file : " #path relatif / absolute
    read path
}

function connectToGithub(name,mail){
    git config --global user.name name
    git config --global user.email email

    echo "Entre your github ssh key: "
    read key
    
    git init
    git remote -v

}