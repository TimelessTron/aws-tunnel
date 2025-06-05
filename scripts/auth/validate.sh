validate_aws() {
  local REQUIRED_VARS=(AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN)

  for var in "${REQUIRED_VARS[@]}"; do
    if [[ -z "${!var:-}" ]]; then
      printf "${ERROR_COLOR}${MSG_ERROR_AWS_NOT_SET}${NC}" $var
      exit 1
    fi
  done
}
