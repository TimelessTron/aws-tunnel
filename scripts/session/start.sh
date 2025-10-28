#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

start_ssm_session() {
  source /app/scripts/env/exportService.sh
  auth_env_file=${AUTH_ENV_FILE:-/app/.aws/aws_env.sh}
  source "$auth_env_file"

  : "${AWS_ACCESS_KEY_ID:?Missing credentials}"

  get_jumphost_id() {
    aws ec2 describe-instances \
      --filters "Name=tag:Name,Values=jumphost" "Name=instance-state-name,Values=running" \
      --query "Reservations[].Instances[].InstanceId" \
      --output text | head -n1 || {
      echo "No running EC2 instance found" >&2
      return 1
    }
  }

  start_session_cmd() {
    jumphost_id="$1"
    aws ssm start-session \
      --region="$SERVICE_REGION" \
      --target "$jumphost_id" \
      --document-name="$SERVICE_SSM_DOCUMENT_NAME" \
      --parameters "$(jq -n --arg remotePort "$SERVICE_SSM_HOST_PORT" --arg localPort "$SERVICE_SSM_CLIENT_PORT" --arg host "$SERVICE_SSM_HOST" '
            .portNumber = [$remotePort] |
            .localPortNumber = [$localPort] |
            .host = [$host]
        ')"
  }

  try_start() {
    jumphost_id="$(get_jumphost_id)" || return 1
    start_session_cmd "$jumphost_id"
  }

  if ! try_start; then
    unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
    : >"$AUTH_ENV_FILE"
    authenticate_service
    source "$auth_env_file"

    if ! try_start; then
      echo -e "${ERROR_COLOR:-}Connection failed${NC:-}" >&2
      exit 1
    fi
  fi
}
