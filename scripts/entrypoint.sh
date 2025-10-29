#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
APP_DIR="${APP_DIR:-/app}"
LANG="${LANG:-en}"

# -----------------------------------------------------------------------------
# Load environment, language, service selection, authentication, session scripts
# -----------------------------------------------------------------------------
source "${APP_DIR}/scripts/env/setup.sh"
source "${APP_DIR}/scripts/lang/${LANG:-en}.sh"
source "${APP_DIR}/scripts/service/choose.sh"
source "${APP_DIR}/scripts/auth/authenticate.sh"
source "${APP_DIR}/scripts/session/start.sh"

# -----------------------------------------------------------------------------
# Main function
# -----------------------------------------------------------------------------
main() {
    # 1️⃣ Service Selection
    echo ""
    echo -e "${COLOR}${MSG_CHOOSE_SERVICE}${NC}"
    echo "-------------------------------------"
    select_service
    echo -e "${COLOR}$MSG_SERVICE_SELECTED ${NAME:-<unknown>}${NC}"

    # 2️⃣ Authenticate Service
    echo ""
    echo "## Authenticating service..."
    echo "-------------------------------------"
    authenticate_service
    echo -e "${COLOR}$MSG_AUTH_SUCCESS${NC}"

    # 3️⃣ Start SSM Session
    echo ""
    echo "## Starting SSM session..."
    echo "-------------------------------------"
    start_session
    echo -e "${COLOR}$MSG_SESSION_STARTED${NC}"
}

# -----------------------------------------------------------------------------
# Execute main
# -----------------------------------------------------------------------------
main
