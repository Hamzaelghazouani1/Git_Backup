
#!/bin/bash

# Function to display help message
display_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -h,  --help               Display this help message"
    echo "  -g,  --github-connection  Connect to GitHub"
    echo "  -b,  --backup-folder      Backup folder"
    echo "  -sh, --show-github-info   Show GitHub connection status"
    echo "  -ch  --change-folder      Change folder path to backup"
    echo "  -f,  --folder-structure   Manage folder structure"
    echo "  -z,  --zip-folder         Zip the backup folder"
    echo "  -c,  --crypt-folder       Encrypt the zipped folder"
    echo "  -d,  --decrypt-folder     Decrypt the encrypted folder"
    echo "  -t,  -change token        Change the token"
    echo "  -p,  --push-to-github     Push encrypted folder to GitHub"
    echo "  -r,  --rerord_historique  shows the history of the backup"
}
