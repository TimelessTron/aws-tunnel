persist_selection() {
  local id="$1"
  local target_file=${TARGET_FILE:-/app/.aws/selected_service}
  local auth_env_file=${AUTH_ENV_FILE:-/app/.aws/aws_env.sh}

  if [[ ! -f "$target_file" ]] || [[ "$(cat "$target_file")" != "$id" ]]; then
    echo "$id" >"$target_file"
    : >"$auth_env_file"
  fi

  NAME_VAR="${id}_NAME"
  echo -e "${SUCCESS_COLOR}Service '${!NAME_VAR}' selected${NC}"
}
