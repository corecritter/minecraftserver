#!/bin/bash

# Replace the following variables with your FTP server details
FTP_SERVER=""
FTP_USER=""
FTP_PASSWORD=""

# URL to list directories (change the path as needed)
FTP_URL="ftp://${FTP_SERVER}/ESD-USB/backup/"

# Use curl to retrieve the directory listing and store it in an array
directories=($(curl -u "${FTP_USER}:${FTP_PASSWORD}" "${FTP_URL}" | grep '^d' | awk '{print $9}'))

min_date_time=$(date +"%Y-%m-%d %H:%M:%S")
# echo "Current DateTime is: $min_date_time"

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
    echo "Deleting: $FTP_URL$dir_to_delete"
    #curl -u "${FTP_USER}:${FTP_PASSWORD}" -X "DELE $dir_to_delete" $FTP_URL
    curl -u "${FTP_USER}:${FTP_PASSWORD}" "${FTP_URL}" -Q "RMD $dir_to_delete"
fi