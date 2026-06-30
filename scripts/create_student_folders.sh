#!/bin/bash

# Define absolute system tracking paths
INPUT_FILE="$HOME/linux_assignment/student_list.txt"
SUBMISSIONS_DIR="$HOME/linux_assignment/student_submissions"
LOG_FILE="$HOME/linux_assignment/logs/folder_creation.log"

# Handle missing input files
if [ ! -f "$INPUT_FILE" ]; then
    echo "CRITICAL ERROR: Input file student_list.txt is missing!"
    exit 1
fi

# Ensure the baseline destination folders exist
mkdir -p "$SUBMISSIONS_DIR"

# Initialize tracking counters and unique group strings
student_count=0
group_list=""
is_header=true

# Read the file line-by-line using horizontal tabs (\t) as the separator
while IFS=$'\t' read -r no matric name class group_num || [ -n "$no" ]; do
    
    # Skip the very first line if it contains the column headers
    if [ "$is_header" = true ]; then
        is_header=false
        continue
    fi

    # Clean up and trim any hidden carriage returns or spaces from variables
    matric_num=$(echo "$matric" | xargs)
    raw_group=$(echo "$group_num" | xargs)

    # Question 5a: Skip empty or malformed data rows cleanly
    if [ -z "$matric_num" ] || [ -z "$raw_group" ]; then
        continue
    fi

    # Format the group string structure and handle spaces
    # Transforms a raw '1' or 'Group 1' into 'Group_1'
    if [[ "$raw_group" =~ ^[0-9]+$ ]]; then
        group_name="Group_$raw_group"
    else
        group_name=$(echo "$raw_group" | tr ' ' '_')
    fi

    # Construct the final nested folder paths
    TARGET_PATH="$SUBMISSIONS_DIR/$group_name/$matric_num"
    
    # Safely generate the directory structure
    mkdir -p "$TARGET_PATH"

    # Write timestamped entries to the logs directory
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Created directory path: $TARGET_PATH" >> "$LOG_FILE"

    # Track unique group labels to avoid duplicate counts
    if [[ ! "$group_list" =~ "$group_name" ]]; then
        group_list="$group_list $group_name"
    fi

    # Increment total processed record metrics
    student_count=$((student_count + 1))

done < "$INPUT_FILE"

# Count total unique groups created
group_count=$(echo "$group_list" | wc -w)

# Sort group names cleanly for the display summary
sorted_groups=$(echo "$group_list" | tr ' ' '\n' | sort -V)

# Print the comprehensive summary report dashboard
echo "========================================="
echo "   Folder Creation Task Complete         "
echo "========================================="
echo "Total students processed : $student_count"
echo "Number of groups created : $group_count"
echo "List of all groups created:"
for g in $sorted_groups; do
    echo "  - $g"
done
echo "========================================="
