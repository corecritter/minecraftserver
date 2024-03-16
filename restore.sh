echo "Attempting to restore from backup"

FTP_SERVER=""
FTP_USER=""
FTP_PASSWORD=""

# URL to list directories (change the path as needed)
FTP_URL="ftp://${FTP_SERVER}/ESD-USB/backup/"

# Use curl to retrieve the directory listing and store it in an array
directories=($(curl -u "${FTP_USER}:${FTP_PASSWORD}" "${FTP_URL}" | grep '^d' | awk '{print $9}'))

max_date_time=$("2024-03-15 20:30:55" +"%Y-%m-%d %H:%M:%S")

total_elements=0

# Loop through the array of directories
for dir in "${directories[@]}"; do
    ((total_elements++))
    formatted_dir=$(echo "$dir" | tr '_' ' ')
    formatted_dir=$(echo "$formatted_dir" | tr '=' ':')
    parsed_date_time=$(date -d "$formatted_dir" +"%Y-%m-%d %H:%M:%S")

    if [[ "$parsed_date_time" > "$max_date_time" ]]; then
        max_date_time=$parsed_date_time
    fi
done

max=1
if [[ $total_elements -gt $max ]]; then
    restore_dir=$(echo "$max_date_time" | tr ' ' '_')
    restore_dir=$(echo "$restore_dir" | tr ':' '=')
    echo "Restoring from : $restore_dir"
    # Log in to the FTP server and get the list of files and directories
    curl -v -u "$FTP_USER:$FTP_PASSWORD" "$FTP_URL$restore_dir" -o /list.txt

    # Read the list and use a loop to download each item
    while IFS= read -r line; do
        # Use curl to download each file or subdirectory
        curl -v -u "$FTP_USER:$FTP_PASSWORD" "$FTP_URL$restore_dir/$line" -O
    done < list.txt

    # Clean up the list file
    rm list.txt

fi