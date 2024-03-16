#!/bin/bash

# Use -v in curl commmands for verbose output
FTP_SERVER=""
FTP_USER=""
FTP_PASSWORD=""
FTP_URL="ftp://${FTP_SERVER}/ESD-USB/backup/"

sleep 60

while true
do
    echo "Performing Backup"

    # Use curl to retrieve the directory listing and store it in an array
    directories=($(curl -u "${FTP_USER}:${FTP_PASSWORD}" "${FTP_URL}" | grep '^d' | awk '{print $9}'))

    min_date_time=$(date +"%Y-%m-%d %H:%M:%S")
    total_elements=0

    # Loop through the array of directories
    for dir in "${directories[@]}"; do
        ((total_elements++))
        formatted_dir=$(echo "$dir" | tr '_' ' ')
        formatted_dir=$(echo "$formatted_dir" | tr '=' ':')
        parsed_date_time=$(date -d "$formatted_dir" +"%Y-%m-%d %H:%M:%S")

        if [[ "$parsed_date_time" < "$min_date_time" ]]; then
            min_date_time=$parsed_date_time
        fi
    done

    max=2
    if [[ $total_elements -gt $max ]]; then
        dir_to_delete=$(echo "$min_date_time" | tr ' ' '_')
        dir_to_delete=$(echo "$dir_to_delete" | tr ':' '=')
        #echo "Deleting: $FTP_URL$dir_to_delete"

        #files=$(curl -v -u "$FTP_USER:$FTP_PASSWORD" "$FTP_URL$dir_to_delete/")
        # Loop through and delete each file
        #for file in $files; do
            #echo "Deleting $file"
            #curl -v -u "$FTP_USER:$FTP_PASSWORD" "$FTP_URL$dir_to_delete/" -Q "DELE $FTP_URL$dir_to_delete/$file"
        #done
        #curl -v -u "$FTP_USER:$FTP_PASSWORD" "$FTP_URL" -Q "RMD $dir_to_delete"
    fi

    current_date_time=$(date +"%Y-%m-%d_%H=%M=%S")

    LOCAL_DIR="/var/minecraft"
    SUB_DIR="$current_date_time"
    BACKUP_DIR="$FTP_URL$SUB_DIR"

    curl -u "$FTP_USER:$FTP_PASSWORD" "$FTP_URL" -Q "MKD $SUB_DIR"

    # Recursively upload files and subfolders
    find "$LOCAL_DIR" -type f -exec curl -u "$FTP_USER:$FTP_PASSWORD" --ftp-create-dirs -T {} "$BACKUP_DIR/{}" \;
    sleep 120
done
