source ./app/src/controller/connection.sh
source ./app/src/view/setup.sh
source ./app/src/controller/folderManipulation.sh
source ./app/src/controller/github.sh

main(){
    startSetup
    getFolder
    echo "Do you want to structure your folder ? [y/n]"
    read response
    if [ $response == "y" ]; then
        filterByType >/dev/null 2>&1 &
    fi
    zipFolder "$(cat ./app/src/data/folder.bin)" "backup" >/dev/null 2>&1 &
    zip_pid=$!
    checkConnection
    clear
    installGit >/dev/null 2>&1 &
    installXdg >/dev/null 2>&1 &
    configGithub
    sshConnectGithub
    save_data 
    mkdir -p /home/$USERNAME/Desktop/backup
    pushToGithub
}
