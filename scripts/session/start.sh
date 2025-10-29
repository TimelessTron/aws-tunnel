#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# -----------------------------------------------------------------------------
# Function: start_session
# Description:
#   Starts an AWS SSM session through a jumphost to the target host.
#   Automatically handles authentication refresh if needed.
# -----------------------------------------------------------------------------
start_session() {
    local TARGET_FILE="${TARGET_FILE:-/app/.aws/selected_service}"
    local AUTH_ENV_FILE="${AUTH_ENV_FILE:-/app/.aws/aws_env.sh}"

    # -------------------------------------------------------------------------
    # Load selected service and auth environment
    # -------------------------------------------------------------------------
    [ -f "$TARGET_FILE" ] || { echo "Target file $TARGET_FILE not found" >&2; exit 1; }
    [ -f "$AUTH_ENV_FILE" ] || touch "$AUTH_ENV_FILE"

    source "$TARGET_FILE"
    source "$AUTH_ENV_FILE"

    # -------------------------------------------------------------------------
    # Set defaults / validate essential variables
    # -------------------------------------------------------------------------
    REGION="${REGION:?Missing REGION in selected service}"
    CLIENT_PORT="${CLIENT_PORT:-33088}"
    DOCUMENT_NAME="${DOCUMENT_NAME:-AWS-StartPortForwardingSession}"

    : "${AWS_ACCESS_KEY_ID:?Missing AWS credentials}"

    # Logging helpers
    log_info()  { echo -e "${COLOR:-}\u2728 $1${NC:-}"; }
    log_success() { echo -e "${SUCCESS_COLOR:-}\u2714 $1${NC:-}"; }
    log_error() { echo -e "${ERROR_COLOR:-}\u274C $1${NC:-}" >&2; }

    log_info "Starting SSM session to host $HOST in region $REGION (local port $CLIENT_PORT)"

    # -------------------------------------------------------------------------
    # Function: get_jumphost_id
    # -------------------------------------------------------------------------
    get_jumphost_id() {
        local jumphost_id
        jumphost_id=$(aws ec2 describe-instances \
            --region "$REGION" \
            --filters "Name=tag:Name,Values=jumphost" "Name=instance-state-name,Values=running" \
            --query "Reservations[].Instances[].InstanceId" \
            --output text | head -n1) || true

        if [[ -z "$jumphost_id" ]]; then
            log_error "No running EC2 jumphost found in region $REGION"
            return 1
        fi

        echo "$jumphost_id"
    }

    # -------------------------------------------------------------------------
    # Function: start_session_cmd
    # -------------------------------------------------------------------------
    start_session_cmd() {
        local jumphost_id="$1"

        log_info "Starting SSM session via jumphost $jumphost_id..."

        aws ssm start-session \
            --region="$REGION" \
            --target "$jumphost_id" \
            --document-name="$DOCUMENT_NAME" \
            --parameters "$(jq -n \
                --arg remotePort "$HOST_PORT" \
                --arg localPort "$CLIENT_PORT" \
                --arg host "$HOST" \
                '{portNumber: [$remotePort], localPortNumber: [$localPort], host: [$host]}')"
    }

    # -------------------------------------------------------------------------
    # Function: try_start
    # -------------------------------------------------------------------------
    try_start() {
        local jumphost_id
        jumphost_id="$(get_jumphost_id)" || return 1
        start_session_cmd "$jumphost_id"
    }

    # -------------------------------------------------------------------------
    # Attempt connection
    # -------------------------------------------------------------------------
    if ! try_start; then
        log_info "Refreshing AWS credentials..."
        unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
        : >"$AUTH_ENV_FILE"
        authenticate_service
        source "$AUTH_ENV_FILE"

        if ! try_start; then
            log_error "Connection failed after authentication refresh"
            exit 1
        fi
    fi

    log_success "SSM session started successfully"
}

# -----------------------------------------------------------------------------
# End of start_session
# -----------------------------------------------------------------------------
