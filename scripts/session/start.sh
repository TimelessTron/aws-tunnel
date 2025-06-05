start_ssm_session() {
  source /app/scripts/env/exportService.sh
  auth_env_file=${AUTH_ENV_FILE:-/app/.aws/aws_env.sh}
  source "$auth_env_file"

  : "${AWS_ACCESS_KEY_ID:?Missing credentials}"

  if ! aws ssm start-session \
    --region="$SERVICE_REGION" \
    --target="$SERVICE_SSM_TARGET" \
    --document-name="$SERVICE_SSM_DOCUMENT_NAME" \
    --parameters "{\"host\":[\"$SERVICE_SSM_HOST\"],\"portNumber\":[\"$SERVICE_SSM_HOST_PORT\"],\"localPortNumber\":[\"$SERVICE_SSM_CLIENT_PORT\"]}"; then

    unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
    : >"$AUTH_ENV_FILE"
    authenticate_service
    source "$auth_env_file"

    if ! aws ssm start-session ...; then
      echo -e "${ERROR_COLOR}Connection failed${NC}" >&2
      exit 1
    fi
  fi
}
