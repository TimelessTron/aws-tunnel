#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

APP_DIR="${APP_DIR:-/app}"
LANG="${LANG:-en}"
source "${APP_DIR}/scripts/lang/${LANG:-en}.sh"
# -----------------------------------------------------------------------------
# Function: connect_mysql
# Description:
#   Generates AWS RDS auth token and optionally connects to MySQL.
#   Can be sourced safely without sofortiger Ausführung.
# -----------------------------------------------------------------------------
connect_mysql() {
    local TARGET_FILE="${TARGET_FILE:-/app/.aws/selected_service}"
    local AUTH_ENV_FILE="${AUTH_ENV_FILE:-/app/.aws/aws_env.sh}"
    local DEFAULT_CLIENT_PORT=33088

    # -------------------------------------------------------------------------
    # Load service and auth variables
    # -------------------------------------------------------------------------
    [ -f "$TARGET_FILE" ] || { printf "$MSG_TARGET_FILE_NOT_FOUND\n" "$TARGET_FILE" >&2; exit 1; }
    [ -f "$AUTH_ENV_FILE" ] || touch "$AUTH_ENV_FILE"

    source "$TARGET_FILE"
    source "$AUTH_ENV_FILE"


    # -------------------------------------------------------------------------
    # Validate required variables
    # -------------------------------------------------------------------------
    local REQUIRED_VARS=(HOST HOST_PORT CLIENT_PORT DB_USER DB_NAME)
    for var in "${REQUIRED_VARS[@]}"; do
        if [[ -z "${!var:-}" ]]; then
            echo "$MSG_MISSING_REQ_VAR $var"
            return 1
        fi
    done

    # -------------------------------------------------------------------------
    # Show connection info
    # -------------------------------------------------------------------------
    echo ""
    echo "$MSG_SERVICE: ${NAME:-<unknown>}"
    echo "$MSG_DB: $DB_NAME @ 127.0.0.1:${CLIENT_PORT:-$DEFAULT_CLIENT_PORT}"
    echo "$MSG_USER: $DB_USER"
    echo "$MSG_TOKEN_VALIDITY"
    echo ""

    # -------------------------------------------------------------------------
    # Generate auth token and connect
    # -------------------------------------------------------------------------
    local TOKEN
    TOKEN="$(aws rds generate-db-auth-token \
        --region "$REGION" \
        --hostname "$HOST" \
        --port "$HOST_PORT" \
        --username "$DB_USER")"

    mysql \
        --host=127.0.0.1 \
        --port="${CLIENT_PORT:-$DEFAULT_CLIENT_PORT}" \
        --user="$DB_USER" \
        --database="$DB_NAME" \
        --password="$TOKEN" \
        --enable-cleartext-plugin

    echo "$MSG_DISCONNECTED $DB_NAME"
}

connect_mysql
