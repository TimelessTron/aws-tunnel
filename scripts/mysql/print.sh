#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

APP_DIR="${APP_DIR:-/app}"
LANG="${LANG:-en}"
source "${APP_DIR}/scripts/lang/${LANG:-en}.sh"
# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
TARGET_FILE="${TARGET_FILE:-/app/.aws/selected_service}"
AUTH_ENV_FILE="${AUTH_ENV_FILE:-/app/.aws/aws_env.sh}"
DEFAULT_CLIENT_PORT=33088

# -----------------------------------------------------------------------------
# Function: connect_mysql
# Description:
#   Generates AWS RDS auth token and optionally connects to MySQL.
#   Also prints the full command and can copy token to clipboard.
# -----------------------------------------------------------------------------
connect_mysql() {
    # Load selected service variables
    [ -f "$TARGET_FILE" ] || { printf "$MSG_TARGET_FILE_NOT_FOUND\n" "$TARGET_FILE" >&2; exit 1; }
    source "$TARGET_FILE"

    [ -f "$AUTH_ENV_FILE" ] || touch "$AUTH_ENV_FILE"
    source "$AUTH_ENV_FILE"

    # Required variables check
    REQUIRED_VARS=(HOST HOST_PORT CLIENT_PORT DB_USER DB_NAME)
    for var in "${REQUIRED_VARS[@]}"; do
        if [[ -z "${!var:-}" ]]; then
            echo "$MSG_MISSING_REQ_VAR $var" >&2
            exit 1
        fi
    done

    # Generate AWS RDS auth token
    local token
    token="$(aws rds generate-db-auth-token \
        --region "$REGION" \
        --hostname "$HOST" \
        --port "$HOST_PORT" \
        --username "$DB_USER")"

    # Print MySQL command
    local mysql_cmd="mysql -h 127.0.0.1 -P ${CLIENT_PORT:-$DEFAULT_CLIENT_PORT} -u $DB_USER -D $DB_NAME --enable-cleartext-plugin --password='$token'"
    echo ""
    echo "-------------------------------------------------"
    echo "$MSG_SERVICE: ${NAME:-<unknown>}"
    echo "$MSG_DB: ${DB_NAME:-<unknown>}"
    echo "$MSG_COMMAND:"
    echo ""
    echo "$mysql_cmd"
    echo ""
    echo "$MSG_TOKEN_VALIDITY"
    echo "-------------------------------------------------"
    echo ""
}

# -----------------------------------------------------------------------------
# Execute
# -----------------------------------------------------------------------------
connect_mysql
