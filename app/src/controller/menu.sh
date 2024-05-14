
source ./app/src/view/menu.sh

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
            ./github_connection.sh
            ;;
        -b|--backup-folder)
            ./backup_folder.sh
            ;;
        -sh|--show-github-info)
            ./show_github_info.sh
            ;;
        -ch|--change-folder)
            ./change_folder.sh
            ;;
        -f|--folder-structure)
            ./folder_structure.sh
            ;;
        -z|--zip-folder)
            ./zip_folder.sh
            ;;
        -c|--crypt-folder)
            ./crypt_folder.sh
            ;;
        -d|--decrypt-folder)
            ./decrypt_folder.sh
            ;;
        -t|--change-token)
            ./change_token.sh
            ;;
        -p|--push-to-github)
            ./push_to_github.sh
            ;;
        -r|--rerord_historique)
            cat save.log - tail -n 10
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