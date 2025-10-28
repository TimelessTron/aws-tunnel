#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

COPY_TOKEN_TO_CLIPBOARD=${COPY_TOKEN_TO_CLIPBOARD:-false}

print_mysql_help() {
  source /app/scripts/env/exportService.sh
  auth_env_file=${AUTH_ENV_FILE:-/app/.aws/aws_env.sh}
  source "$auth_env_file"

  if [ -z "${SERVICE_SSM_HOST:-}" ] || [ -z "${SERVICE_SSM_HOST_PORT:-}" ] || [ -z "${SERVICE_DB_USER:-}" ] || [ -z "${SERVICE_DB_NAME:-}" ]; then
    echo "Required variables: HOST, REMOTE_PORT, DB_USER, DB_NAME" >&2
    return 1
  fi

  TOKEN="$(aws rds generate-db-auth-token --hostname "$SERVICE_SSM_HOST" --port "$SERVICE_SSM_HOST_PORT" --username "$SERVICE_DB_USER")"
  cat <<EOF
    mysql -h 127.0.0.1 -P ${SERVICE_SSM_CLIENT_PORT:-33088} -u $SERVICE_DB_USER -D $SERVICE_DB_NAME --enable-cleartext-plugin --password='$TOKEN'

EOF

  if [ "$COPY_TOKEN_TO_CLIPBOARD" = true ]; then
    if command -v pbcopy >/dev/null 2>&1; then
      printf "%s" "$TOKEN" | pbcopy
      echo "Token copied to clipboard."
    elif command -v xclip >/dev/null 2>&1; then
      printf "%s" "$TOKEN" | xclip -selection clipboard
      echo "Token copied to clipboard."
    else
      echo "No clipboard utility found."
    fi
  fi
}

print_mysql_help
