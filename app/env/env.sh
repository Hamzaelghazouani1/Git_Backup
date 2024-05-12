#!/bin/bash



#Connect github


binary_file="data.bin"

read_data() {
    if [ -f "$binary_file" ]; then
        while IFS=, read -r username email token; do
            echo "Username: $username, Email: $email, Token: $token"
            NAME="$username"
            EMAIL="$email"
            TOKEN="$token"
        done < "$binary_file"
    else
        echo "Binary file not found."
    fi
}


save_data() {
    echo -e "%s\n" "$1,$2,$3" >> "$binary_file"
}

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
    if [ ! "$NAME" ]; then
        echo "Enter your GitHub name: "
        read -r name
        export NAME="$name"
        DATA="true"
    fi

    if [ ! "$EMAIL" ]; then
        echo "Enter your GitHub email: "
        read -r email
        export EMAIL="$email"
        DATA="true"
    fi

    if [ ! "$TOKEN" ]; then
        read -p "Enter your token : " token
        export TOKEN="$token"
        DATA="true"
    fi
    if [ "$DATA"]; then
        save_data "$NAME" "$EMAIL" "$TOKEN"    
    fi

    git config --global user.name $NAME
    git config --global user.email $EMAIL

    echo "Git Config : "
    echo `git config --global --list`
}

sshConnectGithub(){
    echo "Generate ssh key"
    ssh-keygen -t rsa -b 4096 -C $EMAIL
    cat /home/$USERNAME/.ssh/id_rsa.pub
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
    cd /home/$USERNAME/Desktop/test
    touch README.md
    echo "# ${PWD##*/}" >> README.md
    # mkdir /home/$USER/Desktop/test
    git config --global init.defaultBranch main
    # Set up Git configuration to use the access token
    git config --global credential.helper store
    echo -e "https://$NAME:$TOKEN@github.com" > ~/.git-credentials

    git init
    git remote -v
    git remote add origin "https://$TOKEN@github.com/$NAME/${PWD##*/}"
    git add .
    git commit -m "Create project step 3"
    echo "https://$TOKEN@github.com/$NAME/${PWD##*/}"
    git push -u origin main
}

configData(){

    echo "Enter your folder path :"
    read -r path
    export PATH="$path"

    echo "Your path : $PATH"
    echo "Your folder is : ${PATH##*/}"

    folder="${PATH##*/}"
    export FOLDER="$folder"

    if [ ! -d "$FOLDER" ]; then
        echo "Folder exist"
    else
        echo "Do you want to create this folder ? [y/n]"
        read response
        if [ $response == "y" ]; then
            mkdir $FOLDER
        fi
        echo "Folder not exist"
        mkdir $FOLDER
    fi

    echo "What Time do you want to backup your folder ?"
    echo "1- Every 12 h"
    echo "2- Every 1 day"
    echo "3- Every 3 days"
    echo "4- Every 7 days"
    echo "5- Every 15 days"
    echo "6- Every 30 days"
    
    read -r time
    export TIME="$time"

    echo "What is your strategy of folder structure ?"
    echo "1- Filter and Groupe by Day"
    echo "2- Filter and Groupe by name"

    read -r strategy
    export STRATEGY="$strategy"
    if [ "$STRATEGY" == "1" ]; then
        echo "Filter and Groupe by Day"
        
    else
        echo "Filter and Groupe by name"
    fi

    echo -e "%s\n" "$PATH,$TIME,$3" >> "config.bin"

}

filterByType(){
    folder_path="/home/$USERNAME/Downloads"

    # Create a directory to store the grouped files
    folderName="Downloads_$(date +'%d-%m-%Y')"
    mkdir -p "$folderName"

    # Find all files in the folder and group them by type
    declare -A file_categories=(
        ["pdf"]="PDFs"
        ["doc"]="Documents"
        ["docx"]="Documents"
        ["xls"]="Documents"
        ["xlsx"]="Documents"
        ["ppt"]="Documents"
        ["pptx"]="Documents"
        ["odt"]="Documents"
        ["ods"]="Documents"
        ["odp"]="Documents"
        ["html"]="Documents"
        ["xml"]="Documents"
        ["jpeg"]="Images"
        ["jpg"]="Images"
        ["png"]="Images"
        ["gif"]="Images"
        ["bmp"]="Images"
        ["svg"]="Images"
        ["mp4"]="Videos"
        ["mkv"]="Videos"
        ["webm"]="Videos"
        ["avi"]="Videos"
        ["mov"]="Videos"
        ["wmv"]="Videos"
        ["mp3"]="Audio"
        ["wav"]="Audio"
        ["flac"]="Audio"
        ["aac"]="Audio"
        ["wma"]="Audio"
        ["ogg"]="Audio"
        ["txt"]="Text"
        ["rtf"]="Text"
        ["csv"]="Text"
        ["odp"]="Text"
        ["odg"]="Text"
        ["odc"]="Text"
        ["odb"]="Text"
        ["odf"]="Text"
        ["odm"]="Text"
        ["odp"]="Text"
        ["ott"]="Text"
        ["oth"]="Text"
        ["ots"]="Text"
        ["otp"]="Text"
        ["ots"]="Text"
        ["otp"]="Text"
        ["zip"]="Archives"
        ["rar"]="Archives"
        ["tar"]="Archives"
        ["gz"]="Archives"
        ["bz2"]="Archives"
        ["7z"]="Archives"
        ["exe"]="Applications"
        ["dmg"]="Applications"
        ["app"]="Applications"
        ["deb"]="Applications"
        ["rpm"]="Applications"
        ["apk"]="Applications"
        ["jar"]="Applications"
        ["iso"]="Applications"
        ["bin"]="Applications"
        ["snap"]="Applications"
        ["sh"]="Scripts"
        ["bash"]="Scripts"
        ["py"]="Scripts"
        ["js"]="Scripts"
        ["php"]="Scripts"
        ["html"]="Scripts"
        ["css"]="Scripts"
        ["cpp"]="Scripts"
        ["c"]="Scripts"
        ["h"]="Scripts"
        ["hpp"]="Scripts"
        ["java"]="Scripts"
        ["class"]="Scripts"
        ["json"]="Scripts"
        ["sql"]="Scripts"
        ["db"]="Scripts"
        ["dbf"]="Scripts"
        ["md"]="Scripts"
        ["yml"]="Scripts"
        ["yaml"]="Scripts"
        ["conf"]="Scripts"
        ["config"]="Scripts"
        ["log"]="Scripts"
        ["lock"]="Scripts"
        ["key"]="Scripts"
        ["pub"]="Scripts"
        ["pem"]="Scripts"
        ["crt"]="Scripts"
        ["csr"]="Scripts"
        ["cer"]="Scripts"
        ["pfx"]="Scripts"
        ["p12"]="Scripts"
        ["p7b"]="Scripts"
        ["p7r"]="Scripts"
        ["jks"]="Scripts"
        ["keystore"]="Scripts"
        ["truststore"]="Scripts"
        ["ts"]="Scripts"
    )

    # Find files and group them by categories
    find "$folder_path" -type f | while read file; do
        # Get file extension
        file_extension="${file##*.}"
        
        # Determine category or use 'Other' if not found
        category="${file_categories[$file_extension]}"
        if [ -z "$category" ]; then
            category="Other"
        fi
        
        # Create category directory if it doesn't exist
        mkdir -p "$folderName/$category"
        
        # Move the file to the corresponding category directory
        mv "$file" "$folderName/$category/"
    done

    echo "Files have been grouped by type in the '$folderName' directory."
}

start(){
    echo "Hello  $USERNAME !"
    echo "in our application for backup in github platform"
    
    
    read_data
    configGithub
    pushToGithub
    
    echo "Your Github email : $NAME" 
    echo "Your Github User name : $EMAIL"
    echo "Your token : $TOKEN"
    # Manual 
    echo "###########################################"
    echo "#                 manual                  #"
}

run(){
    echo "Welcome in BackupLik"
    start

}

    sshConnectGithub
run
# configData
# filterByType
