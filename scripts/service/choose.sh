#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------------------------------------------
# Function: select_service
# Description:
#   Recursively lists all services defined as .env files in SERVICE_DIR.
#   Allows the user to select a service interactively.
#   Validates required variables and writes them to TARGET_FILE.
# -----------------------------------------------------------------------------
select_service() {
    local SERVICE_DIR="${SERVICE_DIR:-./services}"
    local TARGET_FILE="${TARGET_FILE:-/app/.aws/selected_service}"
    local AUTH_ENV_FILE="${AUTH_ENV_FILE:-/app/.aws/aws_env.sh}"
    local REQUIRED_VARS=(NAME REGION ROLE DOCUMENT_NAME HOST HOST_PORT CLIENT_PORT DB_NAME DB_USER)

    declare -A SERVICE_MAP
    local index=1

    # -------------------------------------------------------------------------
    # Recursive function to walk through directories and list .env services
    # -------------------------------------------------------------------------
    walk_services() {
        local dir="$1"
        local indent="$2"

        shopt -s nullglob dotglob
        for item in "$dir"/*; do
            if [[ -d "$item" ]]; then
                # Print folder name as group header
                local group_name
                group_name=$(basename "$item")
                echo "${indent}${group_name}:"
                walk_services "$item" "  $indent"
            elif [[ -f "$item" && "$item" == *.env ]]; then
                # Extract service display name from .env
                local service_file_name
                service_file_name=$(basename "$item" .env)
                local service_name
                service_name=$(grep -E '^NAME=' "$item" | cut -d'=' -f2- | tr -d '"')

                printf "%s%2d) %s\n" "$indent" "$index" "$service_name"
                SERVICE_MAP[$index]="$item"
                ((index++))
            fi
        done
        shopt -u nullglob dotglob
    }

    # -------------------------------------------------------------------------
    # Start recursive service walk
    # -------------------------------------------------------------------------
    walk_services "$SERVICE_DIR" ""

    # -------------------------------------------------------------------------
    # Ask user for selection
    # -------------------------------------------------------------------------
    echo ""
    read -rp "$MSG_SELECT_NUMBER: " choice
    local selected_file="${SERVICE_MAP[$choice]}"

    if [[ -z "$selected_file" ]]; then
        echo -e "${ERROR_COLOR}${MSG_INVALID_SELECTION}${NC}"
        exit 1
    fi

    # -------------------------------------------------------------------------
    # Load selected service configuration
    # -------------------------------------------------------------------------
    source "$selected_file"

    # -------------------------------------------------------------------------
    # Validate required variables
    # -------------------------------------------------------------------------
    for var in "${REQUIRED_VARS[@]}"; do
        if [[ -z "${!var:-}" ]]; then
            echo -e "${ERROR_COLOR}${MSG_MISSING_VAR}: $var in $selected_file${NC}"
            exit 1
        fi
    done

    # -------------------------------------------------------------------------
    # Write all variables to TARGET_FILE for easy re-loading
    # -------------------------------------------------------------------------
    mkdir -p "$(dirname "$TARGET_FILE")"
    : > "$TARGET_FILE"

    for var in "${REQUIRED_VARS[@]}"; do
        echo "export $var=\"${!var}\"" >> "$TARGET_FILE"
    done

    # Ensure AUTH_ENV_FILE exists
#    mkdir -p "$(dirname "$AUTH_ENV_FILE")"
#    : > "$AUTH_ENV_FILE"

    echo -e "${SUCCESS_COLOR}${MSG_SERVICE} '${NAME}' ${MSG_SELECT}${NC}"
}
