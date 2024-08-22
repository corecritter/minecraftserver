#!/bin/bash

echo "Attempting to restore from backup"

# Source directory to check
SOURCE_DIR="/var/mcbackup/"

# Destination directory
DEST_DIR="/var/minecraft"

# Check if the source directory exists
if [ -d "$SOURCE_DIR" ]; then
  echo "Directory $SOURCE_DIR exists. Copying to $DEST_DIR..."
  cp -r "$SOURCE_DIR"* "$DEST_DIR"
  echo "Copy completed."
else
  echo "Directory $SOURCE_DIR does not exist."
fi