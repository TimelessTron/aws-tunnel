#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# -----------------------------------------------------------------------------
# Function: authenticate_service
# Description:
#   Authenticates the selected service using aws-okta-processor.
#   Stores credentials in AUTH_ENV_FILE for later use.
#   Automatically skips re-authentication if REGION and ROLE are unchanged.
# -----------------------------------------------------------------------------
authenticate_service() {
    local TARGET_FILE="${TARGET_FILE:-/app/.aws/selected_service}"
    local AUTH_ENV_FILE="${AUTH_ENV_FILE:-/app/.aws/aws_env.sh}"

    # -------------------------------------------------------------------------
    # Load service variables
    # -------------------------------------------------------------------------
    [ -f "$TARGET_FILE" ] || { printf "$MSG_TARGET_FILE_NOT_FOUND\n" "$TARGET_FILE" >&2; exit 1; }
    source "$TARGET_FILE"

    # Ensure auth env file exists
    [ -f "$AUTH_ENV_FILE" ] || touch "$AUTH_ENV_FILE"
    source "$AUTH_ENV_FILE"

    # -------------------------------------------------------------------------
    # Skip if credentials already set and REGION/ROLE unchanged
    # -------------------------------------------------------------------------
    if [[ -n "${AWS_ACCESS_KEY_ID:-}" ]]; then
        local OLD_REGION="${LAST_REGION:-}"
        local OLD_ROLE="${LAST_ROLE:-}"

        if [[ "$OLD_REGION" == "$REGION" && "$OLD_ROLE" == "$ROLE" ]]; then
            echo -e "${SUCCESS_COLOR:-}${MSG_CREDENTIAL_ALREADY_SET} $NAME${NC:-}"
            return
        else
            echo -e "${INFO_COLOR:-}${MSG_NEW_REGION_RECONNECT}${NC:-}"
            unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
            : >"$AUTH_ENV_FILE"
        fi
    fi

    # -------------------------------------------------------------------------
    # Authenticate using aws-okta-processor
    # -------------------------------------------------------------------------
    local output
    if ! output="$(aws-okta-processor authenticate \
        --environment \
        --user="$USER" \
        --pass="$PASS" \
        --organization="$ORGANIZATION" \
        --region="$REGION" \
        --role="$ROLE")"; then
        echo -e "${ERROR_COLOR:-}${MSG_AUTHENTICATION_FAILED} $NAME${NC:-}" >&2
        exit 1
    fi

    # Evaluate output to set AWS variables
    eval "$output"

    # -------------------------------------------------------------------------
    # Validate AWS credentials
    # -------------------------------------------------------------------------
    source "${APP_DIR:-/app}/scripts/auth/validate.sh"
    validate_aws

    # -------------------------------------------------------------------------
    # Persist credentials and current REGION/ROLE
    # -------------------------------------------------------------------------
    cat <<EOF >"$AUTH_ENV_FILE"
export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
export AWS_SESSION_TOKEN="$AWS_SESSION_TOKEN"
export LAST_REGION="$REGION"
export LAST_ROLE="$ROLE"
EOF

    echo -e "${SUCCESS_COLOR:-}${MSG_AUTHENTICATION_SUCCESSFULLY} $NAME${NC:-}"
}
