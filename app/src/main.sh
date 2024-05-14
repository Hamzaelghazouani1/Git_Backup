source ./app/src/controller/connection.sh
source ./app/src/view/setup.sh
source ./app/src/controller/folderManipulation.sh
source ./app/src/controller/github.sh
source ./app/lib/crypt/crypt.sh
source ./app/lib/zip/zip.sh
source ./app/src/controller/data.sh
source ./app/src/controller/timeBackup.sh

main(){
    startSetup
    getFolder
    echo "Do you want to structure your folder ? [y/n]"
    read response
    if [ $response == "y" ]; then
        filterByType >/dev/null 2>&1 &
    fi
    zipFolder "$(cat ./app/src/data/folder.bin)" "test" >/dev/null 2>&1 &
    zip_pid=$!
    clear
    checkConnection
    installGit >/dev/null 2>&1 &
    installXdg >/dev/null 2>&1 &
    if [ $zip_pid ]; then
        echo "Zipping folder..."
        
        echo "Please wait..."

        wait $zip_pid
    fi
    read -p "Enter your encryption password: " password
    read -p "Please confirm your encryption password: " confirm_password
    if [ $password != $confirm_password ]; then
        echo "Passwords do not match"
        exit 1
    fi
    encrypt "/home/$USERNAME/Downloads/test/test.tar.gz" "/home/$USERNAME/Downloads/test/test.crypt" "20030629"
    encrypt_pid=$!
    wait $encrypt_pid
    rm -rf /home/$USERNAME/Downloads/test/test.tar.gz
    save_data "done" "./app/src/data/status.bin"
    configGithub
    sshConnectGithub
    pushToGithub
    timeBackup
}