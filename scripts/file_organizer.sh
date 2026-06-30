#!/bin/bash

# 1. Define folder paths for easy management
BASE_DIR="$HOME/linux_assignment"
SOURCE_DIR="$BASE_DIR/documents"

# 2. Create the required destination folders if they don't already exist
mkdir -p "$BASE_DIR/Images"
mkdir -p "$BASE_DIR/Documents"
mkdir -p "$BASE_DIR/Others"

# 3. Initialize counter variables to track moved files
count_docs=0
count_others=0

# 4. Move text, markdown, and PDF files to the Documents folder
for file in "$SOURCE_DIR"/*.txt "$SOURCE_DIR"/*.md "$SOURCE_DIR"/*.pdf; do
    if [ -f "$file" ]; then
        mv "$file" "$BASE_DIR/Documents/"
        count_docs=$((count_docs + 1))
    fi
done

# 5. Move CSV and configuration files to the Others folder
for file in "$SOURCE_DIR"/*.csv "$SOURCE_DIR"/*.conf; do
    if [ -f "$file" ]; then
        mv "$file" "$BASE_DIR/Others/"
        count_others=$((count_others + 1))
    fi
done

# 6. Print a clean summary of the execution results
echo "========================================="
echo "        File Organizer Summary           "
echo "========================================="
echo "Files moved to Documents/ : $count_docs"
echo "Files moved to Others/    : $count_others"
echo "Total files sorted        : $((count_docs + count_others))"
echo "========================================="
