#!/usr/bin/env bash
set -euo pipefail

APP_DIR=${APP_DIR:-/app}
LANG=${LANG:-en}

source "${APP_DIR}/scripts/env/setup.sh"
source "${APP_DIR}/scripts/lang/${LANG}.sh"
source "${APP_DIR}/scripts/service/choose.sh"
source "${APP_DIR}/scripts/auth/authenticate.sh"
source "${APP_DIR}/scripts/session/start.sh"

select_service
authenticate_service
start_ssm_session
