source ./app/src/environment/folder.sh


getFolder(){
    if [ ! "$(cat app/src/data/folder.bin)" ]; then
        echo "Enter the folder path: "
        read folder_path
        if [ ! -d "$folder_path" ]; then
            echo "The folder does not exist"
            getFolder
        fi
        echo $folder_path
        save_data "$folder_path" "./app/src/data/folder.bin"
    fi
}


filterByType(){
    folder_path=$(cat app/src/data/folder.bin)

    # Create a directory to store the grouped files
    folderName="$folder_path/Downloads_$(date +'%d-%m-%Y')"
    mkdir -p "$folderName"

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