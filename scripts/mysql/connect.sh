#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

source /app/scripts/env/exportService.sh
auth_env_file=${AUTH_ENV_FILE:-/app/.aws/aws_env.sh}
source "$auth_env_file"

if [ -z "${SERVICE_SSM_HOST:-}" ] || [ -z "${SERVICE_SSM_HOST_PORT:-}" ] || [ -z "${SERVICE_DB_USER:-}" ] || [ -z "${SERVICE_DB_NAME:-}" ]; then
  echo "Required variables: HOST, REMOTE_PORT, DB_USER, DB_NAME" >&2
  return 1
fi

echo "Start MySQL connection..."
echo "DB: $SERVICE_DB_NAME @ 127.0.0.1:${SERVICE_SSM_CLIENT_PORT:-33088}"
echo "User: $SERVICE_DB_USER"
echo "Token valid for 15 minutes!"
echo ""

read -rp "Connect? [Y/n]" answer
if [[ "$answer" =~ ^[Yy]$ || -z "$answer" ]]; then
  TOKEN="$(aws rds generate-db-auth-token --hostname "$SERVICE_SSM_HOST" --port "$SERVICE_SSM_HOST_PORT" --username "$SERVICE_DB_USER")"

  mysql -h 127.0.0.1 \
    -P "${SERVICE_SSM_CLIENT_PORT:-33088}" \
    -u "$SERVICE_DB_USER" \
    -D "$SERVICE_DB_NAME" \
    --enable-cleartext-plugin \
    --password="$TOKEN"
else
  echo "Aborted"
fi
