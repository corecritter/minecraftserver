echo "Attempting to restore from backup"

FTP_SERVER=""
FTP_SERVER_PORT=""
FTP_USER=""
FTP_PASSWORD=""
FTP_URL="ftp://${FTP_SERVER}:${FTP_SERVER_PORT}/ESD-USB/backup/"

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
    mkdir "/$FTP_SERVER"
    mkdir "/$FTP_SERVER/ESD-USB"
    mkdir "/$FTP_SERVER/ESD-USB/backup"
    mkdir "/$FTP_SERVER/ESD-USB/backup/$restore_dir"
    mkdir "/$FTP_SERVER/ESD-USB/backup/$restore_dir/var"
    mkdir "/$FTP_SERVER/ESD-USB/backup/$restore_dir/var/minecraft"
    restored_directory="/$FTP_SERVER/ESD-USB/backup/$restore_dir/var/minecraft/"
    wget -m --ftp-user=$FTP_USER --ftp-password=$FTP_PASSWORD "$FTP_URL$restore_dir/"
    cp -r "$restored_directory"* /var/minecraft
fi