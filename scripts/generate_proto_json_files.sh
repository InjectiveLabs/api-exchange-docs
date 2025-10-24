#!/bin/bash

# Exit on error, undefined variables, and pipe failures
set -euo pipefail

# Script usage
usage() {
    echo "Usage: $0 <cosmos-sdk-path> <injective-core-path> <indexer-path> <ibc-go-path> <cometbft-path> <wasmd-path>"
    echo
    echo "Generate proto JSON files from repositories"
    echo
    echo "Arguments:"
    echo "  cosmos-sdk-path       Path to the Cosmos SDK repository"
    echo "  injective-core-path   Path to the Injective Core repository"
    echo "  indexer-path         Path to the Indexer repository"
    echo "  ibc-go-path          Path to the IBC Go repository"
    echo "  cometbft-path        Path to the CometBFT repository"
    echo "  wasmd-path           Path to the Wasmd repository"
    echo
    echo "Example:"
    echo "  $0 /tmp/cosmos-sdk /tmp/injective-core /tmp/injective-indexer /tmp/ibc-go /tmp/cometbft /tmp/wasmd"
    exit 1
}

# Check arguments
if [ $# -ne 6 ]; then
    usage
fi

# Repository configurations
init_config() {
    # Base output directory
    OUTPUT_BASE_DIR="source/json_tables"

    # Injective configuration
    INJECTIVE_CHAIN_PATH="$2/injective-chain"
    INJECTIVE_MODULES_PATH="$INJECTIVE_CHAIN_PATH/modules"
    INJECTIVE_TYPES_PATH="$INJECTIVE_CHAIN_PATH/types"
    INJECTIVE_STREAM_PATH="$INJECTIVE_CHAIN_PATH/stream"
    INJECTIVE_PROTO_PATH="$2/proto"
    INJECTIVE_OUTPUT_DIR="$OUTPUT_BASE_DIR/injective"

    # Cosmos SDK configuration
    COSMOS_MODULES_PATH="$1/x"
    COSMOS_CLIENT_GRPC_PATH="$1/client/grpc"
    COSMOS_PROTO_PATH="$1/proto/cosmos"
    COSMOS_OUTPUT_DIR="$OUTPUT_BASE_DIR/cosmos"

    # Indexer configuration
    INDEXER_API_PATH="$3/api/gen/grpc"
    INDEXER_OUTPUT_DIR="$OUTPUT_BASE_DIR/indexer"

    # IBC Go configuration
    IBC_MODULES_PATH="$4/modules"
    IBC_PROTO_PATH="$4/proto/ibc"
    IBC_OUTPUT_DIR="$OUTPUT_BASE_DIR/ibc"

    # CometBFT configuration
    COMETBFT_MODULES_PATH="$5/api/cometbft"
    COMETBFT_PROTO_PATH="$5/proto"
    COMETBFT_OUTPUT_DIR="$OUTPUT_BASE_DIR/cometbft"

    # Wasmd configuration
    WASMD_MODULES_PATH="$6/x"
    WASMD_PROTO_PATH="$6/proto"
    WASMD_OUTPUT_DIR="$OUTPUT_BASE_DIR/wasmd"

    # Export all variables
    export OUTPUT_BASE_DIR INJECTIVE_CHAIN_PATH INJECTIVE_MODULES_PATH INJECTIVE_TYPES_PATH \
           INJECTIVE_STREAM_PATH INJECTIVE_PROTO_PATH INJECTIVE_OUTPUT_DIR COSMOS_MODULES_PATH \
           COSMOS_CLIENT_GRPC_PATH COSMOS_PROTO_PATH COSMOS_OUTPUT_DIR INDEXER_API_PATH INDEXER_OUTPUT_DIR \
           IBC_MODULES_PATH IBC_PROTO_PATH IBC_OUTPUT_DIR \
           COMETBFT_MODULES_PATH COMETBFT_PROTO_PATH COMETBFT_OUTPUT_DIR \
           WASMD_MODULES_PATH WASMD_PROTO_PATH WASMD_OUTPUT_DIR
}

# Check required commands
check_requirements() {
    local required_cmds=("jq")
    local missing_cmds=()

    for cmd in "${required_cmds[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing_cmds+=("$cmd")
        fi
    done

    if [ ${#missing_cmds[@]} -ne 0 ]; then
        echo "Error: Required commands not found: ${missing_cmds[*]}"
        exit 1
    fi
}

# Extract protobuf name from a line
get_proto_name() {
    local line="$1"
    local name=""
    if [[ $line =~ name=([^,\"]+) ]]; then
        name="${BASH_REMATCH[1]}"
    fi
    echo "$name"
}

# Check if field is required
is_required() {
    local line="$1"
    local comment="$2"
    
    local comment_lower
    comment_lower=$(echo "$comment" | tr '[:upper:]' '[:lower:]')
    
    if [[ $comment_lower == *"optional"* ]]; then
        echo "No"
        return
    fi
    
    if [[ $line == *"*"* ]]; then
        if [[ $comment_lower == *"mandatory"* ]]; then
            echo "Yes"
        else
            echo "No"
        fi
    else
        echo "Yes"
    fi
}

# Get field type without pointer symbol and handle array types
get_type() {
    local line="$1"
    local type=""
    if [[ $line =~ [[:space:]]+([^[:space:]]+)[[:space:]]+\`protobuf: ]]; then
        type="${BASH_REMATCH[1]}"
        type="${type//"*"/}"
        if [[ $type =~ ^\[(.*)\](.*)$ ]]; then
            local base_type="${BASH_REMATCH[1]}"
            local remaining="${BASH_REMATCH[2]}"
            type="$base_type$remaining array"
        fi
    fi
    echo "$type"
}

# Process comments in a file and return results via global variables
process_comment() {
    local line="$1"
    
    if [[ $line =~ ^[[:space:]]*\/\*.*\*\/[[:space:]]*$ ]]; then
        # Single-line /* */ comment
        description="${line#*/*}"
        description="${description%*/}"
        description="${description#"${description%%[![:space:]]*}"}"
        description="${description%"${description##*[![:space:]]}"}"
        return
    fi

    if [[ $line =~ ^[[:space:]]*\/\* ]]; then
        # Start of multi-line comment
        in_multiline_comment=true
        local comment_part="${line#*/*}"
        comment_part="${comment_part#"${comment_part%%[![:space:]]*}"}"
        comment_lines+=("$comment_part")
        return
    fi

    if [[ $line =~ \*\/[[:space:]]*$ ]] && [ "$in_multiline_comment" = true ]; then
        # End of multi-line comment
        local comment_part="${line%*/}"
        comment_part="${comment_part#"${comment_part%%[![:space:]]*}"}"
        [ -n "$comment_part" ] && comment_lines+=("$comment_part")
        description=$(IFS=' ' ; echo "${comment_lines[*]}")
        in_multiline_comment=false
        comment_lines=()
        return
    fi

    if [ "$in_multiline_comment" = true ]; then
        # Middle of multi-line comment
        local comment_part="${line#"${line%%[![:space:]]*}"}"
        comment_part="${comment_part#\*}"
        comment_part="${comment_part#"${comment_part%%[![:space:]]*}"}"
        [ -n "$comment_part" ] && comment_lines+=("$comment_part")
        return
    fi

    if [[ $line =~ ^[[:space:]]*//[[:space:]]*(.*) ]]; then
        # Single-line // comment - these can be consecutive for multi-line descriptions
        local comment_text="${BASH_REMATCH[1]}"
        if [ "$in_comment" = false ]; then
            comment_lines=("$comment_text")
            in_comment=true
        else
            comment_lines+=("$comment_text")
        fi
        description=$(IFS=' ' ; echo "${comment_lines[*]}")
        return
    fi

    # Reset comment state if we encounter a non-comment, non-empty line
    # But preserve comment state for empty lines (which might separate comments from fields)
    if [[ ! $line =~ ^[[:space:]]*$ ]] && [[ ! $line =~ ^[[:space:]]*//.*$ ]] && [ "$in_multiline_comment" = false ]; then
        # Only reset if this is not a field definition line that should use the accumulated comment
        if [[ ! $line =~ ^[[:space:]]*[A-Z][[:alnum:]]*[[:space:]] ]] || [[ ! $line =~ protobuf: ]]; then
            in_comment=false
            comment_lines=()
            description=""
        fi
    fi
}

# Process a single .pb.go file
process_pb_file() {
    local pb_file="$1"
    local output_dir="$2"
    
    echo "Processing $pb_file..."
    mkdir -p "$output_dir"
    
    local current_type=""
    local description=""
    local in_comment=false
    local in_multiline_comment=false
    declare -a fields
    declare -a comment_lines
    
    while IFS= read -r line || [ -n "$line" ]; do
        if [[ $line =~ ^type[[:space:]]+([[:alnum:]_]+)[[:space:]]+struct[[:space:]]+\{ ]]; then
            local new_type="${BASH_REMATCH[1]}"
            
            if [ -n "$current_type" ] && [ ${#fields[@]} -gt 0 ] && [[ ! "$current_type" =~ ^Event.+ ]]; then
                (IFS=$'\n'; echo "${fields[*]}") | jq -s '.' > "$output_dir/${current_type}.json"
                echo "Generated $output_dir/${current_type}.json"
            fi
            
            current_type="$new_type"
            fields=()
            description=""
            comment_lines=()
            in_comment=false
            in_multiline_comment=false
            continue
        fi

        # Process comments and update global state
        process_comment "$line"
        
        # Check if this line is a protobuf field definition
        if [[ $line =~ ^[[:space:]]*[A-Z][[:alnum:]]*[[:space:]] ]] && [[ $line =~ protobuf: ]]; then
            if [ -n "$current_type" ] && [[ ! "$current_type" =~ ^Event.+ ]]; then
                local proto_name
                proto_name=$(get_proto_name "$line")
                if [ -n "$proto_name" ]; then
                    local type
                    type=$(get_type "$line")
                    
                    local field_json
                    if [[ "$current_type" =~ ^Msg ]] || [[ "$current_type" =~ Request$ ]] && [[ ! "$current_type" =~ Response$ ]]; then
                        local required
                        required=$(is_required "$line" "$description")
                        field_json=$(jq -n \
                            --arg param "$proto_name" \
                            --arg type "$type" \
                            --arg desc "$description" \
                            --arg req "$required" \
                            '{Parameter: $param, Type: $type, Description: $desc, Required: $req}')
                    else
                        field_json=$(jq -n \
                            --arg param "$proto_name" \
                            --arg type "$type" \
                            --arg desc "$description" \
                            '{Parameter: $param, Type: $type, Description: $desc}')
                    fi
                    
                    fields+=("$field_json")
                fi
                
                # Reset comment state after using the description for a field
                description=""
                in_comment=false
                in_multiline_comment=false
                comment_lines=()
            fi
        fi
    done < "$pb_file"

    # Write the last type if it exists and has fields
    if [ -n "$current_type" ] && [ ${#fields[@]} -gt 0 ] && [[ ! "$current_type" =~ ^Event.+ ]]; then
        (IFS=$'\n'; echo "${fields[*]}") | jq -s '.' > "$output_dir/${current_type}.json"
        echo "Generated $output_dir/${current_type}.json"
    fi
}

# Process all .pb.go files in a directory
process_directory() {
    local source_dir="$1"
    local output_dir="$2"
    
    # Process each .pb.go file in the directory
    while IFS= read -r -d '' pb_file; do
        process_pb_file "$pb_file" "$output_dir"
    done < <(find "$source_dir" -maxdepth 1 -name "*.pb.go" -type f -print0)
}

# Process a directory and its version subdirectories
process_types_directory() {
    local base_dir="$1"
    local output_base="$2"
    local dir_name="$3"
    
    echo "Processing directory: $dir_name"
    
    # Clean up existing output directory
    local output_dir="$output_base/$dir_name"
    rm -rf "$output_dir"
    mkdir -p "$output_dir"
    
    # Process .pb.go files in the main directory
    process_directory "$base_dir" "$output_dir"
    
    # Process version subdirectories if they exist
    while IFS= read -r -d '' version_dir; do
        version_name=$(basename "$version_dir")
        echo "Processing version directory: $version_name"
        
        # Create version-specific output directory
        version_output_dir="$output_dir/$version_name"
        mkdir -p "$version_output_dir"
        
        # Process .pb.go files in the version directory
        process_directory "$version_dir" "$version_output_dir"
    done < <(find "$base_dir" -mindepth 1 -maxdepth 1 -type d -name "v[0-9]*" -print0)
}

# Get relative path in a cross-platform way
get_relative_path() {
    local target="$1"
    local base="$2"
    
    # Convert both paths to absolute paths
    local abs_target
    local abs_base
    abs_target=$(cd "$(dirname "$target")" && pwd)/$(basename "$target")
    abs_base=$(cd "$base" && pwd)
    
    # Remove the base path from the target path
    echo "${abs_target#$abs_base/}"
}

# Process a single .proto file for enums
process_proto_file() {
    local proto_file="$1"
    local output_base="$2"
    local proto_base="$3"
    
    echo "Processing proto file: $proto_file"
    
    # Get the relative path from proto directory, removing the initial "injective/" or "cosmos/" if present
    local rel_path
    rel_path=$(get_relative_path "$proto_file" "$proto_base")
    rel_path=${rel_path#injective/}
    rel_path=${rel_path#cosmos/}
    local dir_path
    dir_path=$(dirname "$rel_path")
    local output_dir="$output_base/$dir_path"
    
    # Variables for processing
    local current_enum=""
    declare -a enum_entries
    local in_enum=false
    local found_enums=false
    
    # Read file line by line
    while IFS= read -r line || [ -n "$line" ]; do
        # Remove any trailing semicolons and whitespace
        line="${line%%;}"
        line="${line%"${line##*[![:space:]]}"}"
        
        # Check for enum definition
        if [[ $line =~ ^[[:space:]]*enum[[:space:]]+([[:alnum:]_]+)[[:space:]]*\{?[[:space:]]*$ ]]; then
            current_enum="${BASH_REMATCH[1]}"
            enum_entries=()
            in_enum=true
            found_enums=true
            continue
        fi
        
        # Check for end of enum
        if [[ $in_enum == true && $line =~ ^[[:space:]]*\}[[:space:]]*$ ]]; then
            # Write enum entries to file if we have any
            if [ ${#enum_entries[@]} -gt 0 ]; then
                # Create output directory only when we have enums to write
                mkdir -p "$output_dir"
                (IFS=$'\n'; echo "${enum_entries[*]}") | jq -s '.' > "$output_dir/${current_enum}.json"
                echo "Generated $output_dir/${current_enum}.json"
            fi
            in_enum=false
            current_enum=""
            continue
        fi
        
        # Process enum entry
        if [[ $in_enum == true && $line =~ ^[[:space:]]*([[:alnum:]_]+)[[:space:]]*=[[:space:]]*([0-9]+) ]]; then
            local name="${BASH_REMATCH[1]}"
            local code="${BASH_REMATCH[2]}"
            
            # Create JSON object for this enum entry with Code first
            local entry_json
            entry_json=$(jq -n \
                --arg code "$code" \
                --arg name "$name" \
                '{Code: $code, Name: $name}')
            
            enum_entries+=("$entry_json")
        fi
    done < "$proto_file"

    # If no enums were found, indicate this in the output
    if [ "$found_enums" = false ]; then
        echo "No enums found in $proto_file"
    fi
}

# Process all .proto files in a directory recursively
process_proto_directory() {
    local source_dir="$1"
    local output_base="$2"
    
    echo "Processing proto files in $source_dir..."
    
    # Process each .proto file in the directory and subdirectories
    while IFS= read -r -d '' proto_file; do
        process_proto_file "$proto_file" "$output_base" "$source_dir"
    done < <(find "$source_dir" -type f -name "*.proto" -print0)
}

# Process a repository's modules
process_repository_modules() {
    local modules_path="$1"
    local output_dir="$2"
    
    # Process each module
    for module_dir in "$modules_path"/*/; do
        module_name=$(basename "$module_dir")
        
        if [ -d "$module_dir/types" ]; then
            process_types_directory "$module_dir/types" "$output_dir" "$module_name"
        else
            # Check if module has .pb.go files in the main directory
            if compgen -G "$module_dir/*.pb.go" > /dev/null 2>&1; then
                echo "Processing module with direct .pb.go files: $module_name"
                mkdir -p "$output_dir/$module_name"
                process_directory "$module_dir" "$output_dir/$module_name"
            fi
        fi
    done
}

# Process Cosmos SDK types directory and its subdirectories
process_cosmos_types_directory() {
    local types_path="$1"
    local output_dir="$2"
    
    echo "Processing Cosmos SDK types directory: $types_path"
    process_directory_recursive "$types_path" "$output_dir"
}

# Generic recursive directory processor for .pb.go files
process_directory_recursive() {
    local source_path="$1"
    local output_base="$2"
    local max_depth="${3:-10}"  # Safety limit to prevent infinite recursion
    
    # Safety check for recursion depth
    if [ "$max_depth" -le 0 ]; then
        echo "Warning: Maximum recursion depth reached for $source_path"
        return
    fi
    
    # Process .pb.go files in the current directory
    if compgen -G "$source_path/*.pb.go" > /dev/null 2>&1; then
        echo "Processing .pb.go files in: $source_path"
        process_directory "$source_path" "$output_base"
    fi
    
    # Process each subdirectory that contains .pb.go files
    for subdir in "$source_path"/*/; do
        if [ -d "$subdir" ]; then
            local subdir_name=$(basename "$subdir")
            
            # Check if this subdirectory or its children contain .pb.go files
            if find "$subdir" -name "*.pb.go" -type f | head -1 | grep -q .; then
                echo "Checking subdirectory: $subdir_name"
                local subdir_output="$output_base/$subdir_name"
                mkdir -p "$subdir_output"
                
                # Recursively process the subdirectory
                process_directory_recursive "$subdir" "$subdir_output" $((max_depth - 1))
            fi
        fi
    done
}



# Process Indexer module
process_indexer_module() {
    local module_dir="$1"
    local output_dir="$2"
    local module_name=$(basename "$module_dir")
    
    echo "Processing Indexer module: $module_name"
    
    # Create module-specific output directory
    local module_output_dir="$output_dir/$module_name"
    mkdir -p "$module_output_dir"
    
    # Process pb directory if it exists
    local pb_dir="$module_dir/pb"
    if [ -d "$pb_dir" ]; then
        # Process .pb.go files
        process_directory "$pb_dir" "$module_output_dir"
        
        # Process .proto files
        process_proto_directory "$pb_dir" "$module_output_dir"
    fi
}

# Process all Indexer modules
process_indexer_modules() {
    local api_path="$1"
    local output_dir="$2"
    
    echo "Processing Indexer modules..."
    
    # Process each module directory
    for module_dir in "$api_path"/*/; do
        if [ -d "$module_dir" ]; then
            process_indexer_module "$module_dir" "$output_dir"
        fi
    done
}

# Process IBC modules - recursively find and process all 'types' folders
process_ibc_modules() {
    local modules_path="$1"
    local output_dir="$2"
    
    echo "Processing IBC modules..."
    
    # Process each module
    for module_dir in "$modules_path"/*/; do
        if [ -d "$module_dir" ]; then
            module_name=$(basename "$module_dir")
            echo "Processing IBC module: $module_name"
            
            # Find all 'types' directories within this module recursively
            while IFS= read -r -d '' types_dir; do
                # Get the relative path from the modules_path to preserve structure
                local rel_path="${types_dir#$modules_path/}"
                
                # Create the corresponding output directory structure
                local types_output_dir="$output_dir/$rel_path"
                mkdir -p "$types_output_dir"
                
                echo "Processing types directory: $rel_path"
                
                # Process .pb.go files in this types directory
                process_directory "$types_dir" "$types_output_dir"
                
            done < <(find "$module_dir" -type d -name "types" -print0)
        fi
    done
}

# Process CometBFT modules - recursively find and process all .pb.go files
process_cometbft_modules() {
    local modules_path="$1"
    local output_dir="$2"
    
    echo "Processing CometBFT modules..."
    
    # Process each module
    for module_dir in "$modules_path"/*/; do
        if [ -d "$module_dir" ]; then
            module_name=$(basename "$module_dir")
            echo "Processing CometBFT module: $module_name"
            
            # Get the relative path from the modules_path to preserve structure
            local rel_path="${module_dir#$modules_path/}"
            # Remove trailing slash
            rel_path="${rel_path%/}"
            
            # Create the corresponding output directory structure
            local module_output_dir="$output_dir/$rel_path"
            mkdir -p "$module_output_dir"
            
            echo "Processing CometBFT module directory: $rel_path"
            
            # Process all .pb.go files recursively in this module directory
            process_directory_recursive "$module_dir" "$module_output_dir"
        fi
    done
}

# Initialize configuration with provided paths
init_config "$1" "$2" "$3" "$4" "$5" "$6"

# Check requirements first
check_requirements

# Create base output directories
mkdir -p "$INJECTIVE_OUTPUT_DIR" "$COSMOS_OUTPUT_DIR" "$INDEXER_OUTPUT_DIR" "$IBC_OUTPUT_DIR" "$COMETBFT_OUTPUT_DIR" "$WASMD_OUTPUT_DIR"

# Process Injective modules
echo "Processing Injective modules..."
[ -d "$INJECTIVE_TYPES_PATH" ] && process_types_directory "$INJECTIVE_TYPES_PATH" "$INJECTIVE_OUTPUT_DIR" "types"
[ -d "$INJECTIVE_STREAM_PATH/types" ] && process_types_directory "$INJECTIVE_STREAM_PATH/types" "$INJECTIVE_OUTPUT_DIR" "stream"
process_repository_modules "$INJECTIVE_MODULES_PATH" "$INJECTIVE_OUTPUT_DIR"
[ -d "$INJECTIVE_PROTO_PATH" ] && process_proto_directory "$INJECTIVE_PROTO_PATH" "$INJECTIVE_OUTPUT_DIR"

# Process Cosmos SDK modules
echo "Processing Cosmos SDK modules..."
process_repository_modules "$COSMOS_MODULES_PATH" "$COSMOS_OUTPUT_DIR"

# Process Cosmos SDK types directory and its subdirectories
if [ -d "$1/types" ]; then
    echo "Processing Cosmos SDK types directory..."
    process_cosmos_types_directory "$1/types" "$COSMOS_OUTPUT_DIR"
fi

# Process Cosmos SDK client/grpc directory and its subdirectories
if [ -d "$COSMOS_CLIENT_GRPC_PATH" ]; then
    echo "Processing Cosmos SDK client/grpc directory..."
    process_directory_recursive "$COSMOS_CLIENT_GRPC_PATH" "$COSMOS_OUTPUT_DIR"
fi

[ -d "$COSMOS_PROTO_PATH" ] && process_proto_directory "$COSMOS_PROTO_PATH" "$COSMOS_OUTPUT_DIR"

# Process Indexer modules
[ -d "$INDEXER_API_PATH" ] && process_indexer_modules "$INDEXER_API_PATH" "$INDEXER_OUTPUT_DIR"

# Process IBC modules
echo "Processing IBC modules..."
[ -d "$IBC_MODULES_PATH" ] && process_ibc_modules "$IBC_MODULES_PATH" "$IBC_OUTPUT_DIR"
[ -d "$IBC_PROTO_PATH" ] && process_proto_directory "$IBC_PROTO_PATH" "$IBC_OUTPUT_DIR"

# Process CometBFT modules
echo "Processing CometBFT modules..."
[ -d "$COMETBFT_MODULES_PATH" ] && process_cometbft_modules "$COMETBFT_MODULES_PATH" "$COMETBFT_OUTPUT_DIR"
[ -d "$COMETBFT_PROTO_PATH" ] && process_proto_directory "$COMETBFT_PROTO_PATH" "$COMETBFT_OUTPUT_DIR"

# Process Wasmd modules
echo "Processing Wasmd modules..."
[ -d "$WASMD_MODULES_PATH" ] && process_repository_modules "$WASMD_MODULES_PATH" "$WASMD_OUTPUT_DIR"
[ -d "$WASMD_PROTO_PATH" ] && process_proto_directory "$WASMD_PROTO_PATH" "$WASMD_OUTPUT_DIR"

echo "Processing complete!" 