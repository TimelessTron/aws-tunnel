#!/usr/bin/env bash
set -euo pipefail

select_service() {
  : "${SERVICES:?Environment variable SERVICES is not set}"
  IFS=',' read -ra SERVICE_IDS <<<"$SERVICES"

  echo -e "${COLOR}${MSG_CHOOSE_SERVICE}${NC}"
  declare -A SERVICE_MAP
  local i=1

  for SID in "${SERVICE_IDS[@]}"; do
    NAME_VAR="${SID}_NAME"
    echo " $i) ${!NAME_VAR}"
    SERVICE_MAP[$i]="$SID"
    ((i++))
  done

  echo ""
  read -rp "Selection (number): " CHOICE
  SELECTED="${SERVICE_MAP[$CHOICE]:-}"
  if [[ -z "$SELECTED" ]]; then
    echo -e "${ERROR_COLOR}${MSG_INVALID_SELECTION}${NC}"
    exit 1
  fi

  source $APP_DIR/scripts/service/validate.sh
  validate_service "$SELECTED"

  source $APP_DIR/scripts/service/persist.sh
  persist_selection "$SELECTED"
}
