#!/bin/bash

# Ensure exactly two arguments are provided (branch name and filename list file)
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <test_pool> <branch_name> <path_to_filenames_file>"
    exit 1
fi

test_pool="$1"
branch_name="$2"
filename_list_file="$3"

# Define the root directory to prepend
# ROOT_DIR="~/Diamond_HiL_TestAutomation/"
HYD_POOL="hydraulics/Python/TestPool"
EBM_POOL="ebm/Python/TestPool"

case "$test_pool" in
    "hyd")
        ROOT_DIR="$HYD_POOL"
        ;;
    "ebm")
        ROOT_DIR="$EBM_POOL"
        ;;
    *)
        echo "Invalid test pool. Use 'hyd' or 'ebm'."
	;;
esac
      

# Check if the filename list file exists
if [ ! -f "$filename_list_file" ]; then
    echo "File not found: $filename_list_file"
    exit 1
fi

# Loop through each line in the filename list file
while IFS= read -r filename; do
    # Clean up the filename (remove trailing spaces, carriage returns, etc.)
    filename=$(echo "$filename" | awk '{$1=$1;print}')

    # Skip empty lines
    if [ -z "$filename" ]; then
        continue
    fi

    # Prepend the root directory to the filename
    full_path="${ROOT_DIR}/${filename}"

    # Run the git checkout command with the branch name
    git checkout "$branch_name" "$full_path"

    # Check if the git checkout command was successful
    if [ $? -eq 0 ]; then
        echo "Checked out: $full_path on branch $branch_name"
    else
        echo "Failed to check out: $full_path on branch $branch_name"
    fi
done < "$filename_list_file"

