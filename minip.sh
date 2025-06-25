#!/bin/bash

# Get user inputs for directory, file size, and file age
read -p "Enter directory to clean up: " DIR
read -p "Enter file size threshold (e.g., 100M for 100 MB, 1G for 1 GB): " SIZE
read -p "Enter file age threshold in days (e.g., +30 for files older than 30 days): " AGE

# Check if the directory exists
if [ ! -d "$DIR" ]; then
  echo "Directory does not exist."
  exit 1
fi

# Function to confirm deletion
confirm_deletion() {
  read -p "Are you sure you want to delete $1? (y/n): " CONFIRM
  if [ "$CONFIRM" = "y" ]; then
    rm -f "$1"
    echo "$1 has been deleted."
  else
    echo "$1 has been skipped."
  fi
}

# Find and delete files larger than the specified size
find $DIR -type f -size $SIZE | while read file; do
  confirm_deletion "$file"
done

# Find and delete files older than the specified age
find $DIR -type f -mtime $AGE | while read file; do
  confirm_deletion "$file"
done

echo "Cleanup complete."

