#!/bin/bash

# Exit on any error
set -e

# Script usage
usage() {
    echo "Usage: $0 <cosmos-sdk-path> <injective-core-path>"
    echo
    echo "Extract error definitions from Cosmos SDK and Injective Core repositories"
    echo
    echo "Arguments:"
    echo "  cosmos-sdk-path       Path to the Cosmos SDK repository"
    echo "  injective-core-path   Path to the Injective Core repository"
    echo
    echo "Example:"
    echo "  $0 /tmp/cosmos-sdk /tmp/injective-core"
    exit 1
}

# Check arguments
if [ $# -ne 2 ]; then
    usage
fi

# Configuration
COSMOS_SDK_DIR="$1"
INJECTIVE_CORE_DIR="$2"
BASE_OUTPUT_DIR="source/json_tables"

# Store the original directory
ORIGINAL_DIR=$(pwd)

# Check dependencies
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed. Please install jq first."
    exit 1
fi

# Function to extract errors from a file and append to JSON array
extract_errors() {
    local file=$1
    local json_objects=""
    local error_pattern='errors\.Register\([[:space:]]*([^,]+)[[:space:]]*,[[:space:]]*([^,]+)[[:space:]]*,[[:space:]]*\"([^\"]+)\"'
    
    while IFS= read -r line; do
        if [[ $line =~ $error_pattern ]]; then
            error_code=$(echo "${BASH_REMATCH[2]}" | tr -d ' ')
            description="${BASH_REMATCH[3]}"
            
            if [ -z "$json_objects" ]; then
                json_objects="{\"Error Code\": $error_code, \"Description\": \"$description\"}"
            else
                json_objects="$json_objects,{\"Error Code\": $error_code, \"Description\": \"$description\"}"
            fi
        fi
    done < "$file"
    
    if [ -n "$json_objects" ]; then
        echo "[$json_objects]" | jq '.'
        return 0
    fi
    return 1
}

# Function to process modules in a directory
process_modules() {
    local base_dir=$1
    local output_dir=$2
    local modules_path=$3
    
    echo "Processing modules in $modules_path..."
    
    cd "$base_dir"
    for module in "$modules_path"/*; do
        # Skip if not a directory
        [ ! -d "$module" ] && continue
        
        module_name=$(basename "$module")
        echo "Processing module: $module_name"
        
        json_content=""
        
        # Check for errors.go in main folder
        if [ -f "$module/errors.go" ] && content=$(extract_errors "$module/errors.go"); then
            json_content="$content"
        fi
        
        # Check for errors.go in types subfolder
        if [ -f "$module/types/errors.go" ] && types_content=$(extract_errors "$module/types/errors.go"); then
            if [ -n "$json_content" ]; then
                json_content=$(echo "$json_content" "$types_content" | jq -s 'add')
            else
                json_content="$types_content"
            fi
        fi
        
        # Save if we found any errors
        if [ -n "$json_content" ]; then
            echo "$json_content" > "$ORIGINAL_DIR/$output_dir/$module_name.json"
            echo "  Found errors in module $module_name"
        else
            echo "  No errors found in module $module_name"
        fi
    done
    cd "$ORIGINAL_DIR"
}

# Clean up any existing files and create directory structure
echo "Setting up directories..."
rm -rf "$BASE_OUTPUT_DIR/errors" "$BASE_OUTPUT_DIR/chain/errors"
mkdir -p "$BASE_OUTPUT_DIR/errors" "$BASE_OUTPUT_DIR/chain/errors"

# Process Cosmos SDK repository
echo "Processing Cosmos SDK repository..."
process_modules "$COSMOS_SDK_DIR" "$BASE_OUTPUT_DIR/errors" "x"

# Process Injective Core repository
echo "Processing Injective Core repository..."
process_modules "$INJECTIVE_CORE_DIR" "$BASE_OUTPUT_DIR/chain/errors" "injective-chain/modules"

echo "Error extraction complete. JSON files have been created in:"
echo "- $BASE_OUTPUT_DIR/errors (Cosmos SDK modules)"
echo "- $BASE_OUTPUT_DIR/chain/errors (Injective Core modules)" 