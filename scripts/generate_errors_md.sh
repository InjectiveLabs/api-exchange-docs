#!/bin/bash

# Exit on any error
set -e

OUTPUT_FILE="source/includes/_errors.md"
COSMOS_ERRORS_DIR="source/json_tables/errors"
INJECTIVE_ERRORS_DIR="source/json_tables/chain/errors"

# Function to add a module's errors to the markdown file
add_module_errors() {
    local file=$1
    local prefix=$2
    local module_name=$(basename "$file" .json)
    
    # Just capitalize the first letter
    local capitalized_name=$(echo "$module_name" | perl -pe 's/^(.)/\u$1/')
    
    echo "## ${capitalized_name} module" >> "$OUTPUT_FILE"
    echo >> "$OUTPUT_FILE"
    echo "<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./$file) -->" >> "$OUTPUT_FILE"
    echo "<!-- MARKDOWN-AUTO-DOCS:END -->" >> "$OUTPUT_FILE"
    echo >> "$OUTPUT_FILE"
}

# Remove existing file if it exists
rm -f "$OUTPUT_FILE"

# Add Cosmos SDK section
if [ -d "$COSMOS_ERRORS_DIR" ]; then
    echo "# Cosmos SDK errors" >> "$OUTPUT_FILE"
    echo >> "$OUTPUT_FILE"
    for file in "$COSMOS_ERRORS_DIR"/*.json; do
        [ -f "$file" ] || continue
        add_module_errors "$file" "Cosmos SDK"
    done
fi

# Add Injective section
if [ -d "$INJECTIVE_ERRORS_DIR" ]; then
    echo "# Injective errors" >> "$OUTPUT_FILE"
    echo >> "$OUTPUT_FILE"
    for file in "$INJECTIVE_ERRORS_DIR"/*.json; do
        [ -f "$file" ] || continue
        add_module_errors "$file" "Injective"
    done
fi

echo "Generated errors documentation in $OUTPUT_FILE" 