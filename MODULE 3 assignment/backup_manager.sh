#!/bin/sh

#Task-1
echo "Task-1 Command Line arguments"

source_directory="$1"
backup_directory="$2"
file_ext="$3"
no_of_arguments="$#"

echo "The added arguements:"
echo "Source directory : $source_directory"
echo "Backup directory : $backup_directory"
echo "File extension : $file_ext"
echo ""

#Task-2

echo "Finding the files using globbing"
echo ""

# Task-2: Globbing
echo "Finding the files using globbing..."

for file in "$source_directory"/*"$file_ext"; do
    if [ -f "$file" ]; then
        echo "Found: $(basename "$file")"
    else
        echo "No files found matching that extension."
    fi
done


#Task-3

echo "The export variable"

f_count=0
for i in "$source_dir"/*"$file_ext"; do
if [[ -f "$i" ]]; then
((f_count++))
fi
done

export BACKUP_COUNT=$f_count

#TASK_4

echo "Total number of $file_ext files to backup: $BACKUP_COUNT"

echo "Creating Associative Array"

declare -a file_array

for i in "$source_directory"/*"$file_ext"; do 
    if [[ -f "$i" ]]; then
        file_array+=("$(basename "$i")")  
    fi
done

echo "Files listed with index:"
for i in "${!file_array[@]}"; do
echo " [$i] ${file_array[$i]}"
done
