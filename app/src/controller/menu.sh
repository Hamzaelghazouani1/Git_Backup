
source ./app/src/view/menu.sh
source ./app/src/controller/connection.sh
source ./app/src/view/setup.sh
source ./app/src/controller/folderManipulation.sh
source ./app/src/controller/github.sh
source ./app/lib/crypt/crypt.sh
source ./app/lib/zip/zip.sh
source ./app/src/controller/data.sh
source ./app/src/controller/timeBackup.sh
# Parse command-line arguments
options(){
if [[ $# -eq 0 ]]; then
    echo "Error: Missing argument. Use -h or --help for usage."
    exit 0
fi
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            display_help
            exit 0
            ;;
        -g|--github-connection)
            checkConnection
            ;;
        -b|--backup-folder)
            main
            ;;
        -sh|--show-github-info)
            list_gitinfo
            ;;
        -ch|--change-folder)
            read -p "Enter the folder path: " folder_path
            save_data "$folder_path" "./app/src/data/folder.bin"
            ;;
        -f|--folder-structure)
            folder="$(cat ./app/src/data/folder.bin)"
            tree "$folder"
            ;;
        -z|--zip-folder)
            ./zip_folder.sh
            ;;
        -c|--crypt-folder)
            echo "Enter your encryption password: "
            echo "Encripting..."            
            ;;
        -d|--decrypt-folder)
            echo "decripting..."            
            ;;
        -t|--change-token)
            read -p "Enter your GitHub token: " token
            save_data "$token" "./app/src/data/token.bin"
            ;;
        -p|--push-to-github)
            configGithub
            sshConnectGithub
            pushToGithub
            ;;
        -r|--rerord_historique)
        
            cat "./app/log/data.log" - tail -n 10
            ;; 
        # Add other options and their actions here
        *)
            echo "Error: Unknown option '$1'. Use -h or --help for usage."
            exit 1
            ;;
    esac
    shift
done
}