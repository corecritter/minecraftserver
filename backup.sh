#!/bin/bash

# Source directory to check
SOURCE_DIR="/var/minecraft/"

# Destination directory
DEST_DIR="/var/mcbackup"

if [ -d "$DEST_DIR" ]; then
    mkdir "$DEST_DIR"
fi

sleep 600

while true
do
    echo "Performing Backup"

    if [ -d "$SOURCE_DIR" ]; then
        echo "Backing up $SOURCE_DIR. Copying to $DEST_DIR..."
        cp -r "$SOURCE_DIR"* "$DEST_DIR"
        echo "Backup completed."
    else
        echo "Directory $SOURCE_DIR does not exist."
    fi

    sleep 600
done
