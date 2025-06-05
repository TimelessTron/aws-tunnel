authenticate_service() {
  source /app/scripts/env/exportService.sh
  local auth_env_file=${AUTH_ENV_FILE:-/app/.aws/aws_env.sh}

  source "$auth_env_file"

  if [[ -n "${AWS_ACCESS_KEY_ID:-}" ]]; then
    echo "AWS credentials already set"
    return
  fi

  output="$(aws-okta-processor authenticate \
    --environment \
    --user="$USER" \
    --pass="$PASS" \
    --organization="$ORGANIZATION" \
    --region="$SERVICE_REGION" \
    --role="$SERVICE_ROLE")"
  status=$?

  if [[ $status -ne 0 ]]; then
    echo -e "${ERROR_COLOR}Authentication failed for service: $SERVICE_NAME ${NC}" >&2
    exit 1
  fi

  eval "$output"

  source $APP_DIR/scripts/auth/validate.sh
  validate_aws

  cat <<EOF >"$auth_env_file"
export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
export AWS_SESSION_TOKEN="$AWS_SESSION_TOKEN"
EOF

  echo -e "${SUCCESS_COLOR}Authenticated successfully for service: $SERVICE_NAME ${NC}"
}
