#!/bin/bash

# Source directory to check
SOURCE_DIR="/var/minecraft"

# Destination directory
DEST_DIR="/var/backup"

sleep 180

while true
do
    echo "Performing Backup"

    # Check if the source directory exists
    if [ -d "$SOURCE_DIR" ]; then
        echo "Backing up $SOURCE_DIR. Copying to $DEST_DIR..."
        cp -r "$SOURCE_DIR" "$DEST_DIR"
        echo "Backup completed."
    else
        echo "Directory $SOURCE_DIR does not exist."
    fi

    sleep 120
done
