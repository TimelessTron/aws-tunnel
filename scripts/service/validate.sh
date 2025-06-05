validate_service() {
  local id="$1"
  local REQUIRED_VARS=(NAME REGION ROLE SSM_TARGET SSM_DOCUMENT_NAME SSM_HOST SSM_HOST_PORT SSM_CLIENT_PORT)

  for var in "${REQUIRED_VARS[@]}"; do
    full_var="${id}_${var}"
    if [[ -z "${!full_var:-}" ]]; then
      printf "${ERROR_COLOR}${MSG_ERROR_ENV_NOT_SET}${NC}" $full_var
      #      echo -e "${ERROR_COLOR}Missing variable: $full_var${NC}"
      exit 1
    fi
  done
}
