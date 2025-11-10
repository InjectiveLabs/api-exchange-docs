#!/bin/bash

# Exit on any error
set -e

OUTPUT_FILE="source/includes/_errors.md"
ERRORS_DIR="source/json_tables/errors"

# Function to add a module's errors to the markdown file
add_module_errors() {
    local file=$1
    local module_name=$(basename "$file" .json)
    
    # Remove "_errors" suffix and capitalize the first letter
    local clean_name=$(echo "$module_name" | sed 's/_errors$//')
    local capitalized_name=$(echo "$clean_name" | perl -pe 's/^(.)/\u$1/')
    
    echo "## ${capitalized_name} module" >> "$OUTPUT_FILE"
    echo >> "$OUTPUT_FILE"
    echo "<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./$file) -->" >> "$OUTPUT_FILE"
    echo "<!-- MARKDOWN-AUTO-DOCS:END -->" >> "$OUTPUT_FILE"
    echo >> "$OUTPUT_FILE"
}

# Remove existing file if it exists
rm -f "$OUTPUT_FILE"

# Add header
echo "# Error Codes" >> "$OUTPUT_FILE"
echo >> "$OUTPUT_FILE"
echo "This section lists all error codes from various modules in the Injective ecosystem." >> "$OUTPUT_FILE"
echo >> "$OUTPUT_FILE"

# Process all error files in the errors directory
if [ -d "$ERRORS_DIR" ]; then
    # Sort files alphabetically for consistent output
    for file in $(ls "$ERRORS_DIR"/*.json 2>/dev/null | sort); do
        [ -f "$file" ] || continue
        add_module_errors "$file"
    done
fi

echo "Generated errors documentation in $OUTPUT_FILE" 