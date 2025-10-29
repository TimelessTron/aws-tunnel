#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Service selection messages
# -----------------------------------------------------------------------------
export MSG_CHOOSE_SERVICE="✨ Please choose a service:"
export MSG_INVALID_SELECTION="❌ Invalid selection! Please try again."
export MSG_SELECT_NUMBER="🔢 Selection (number)"
export MSG_SELECT="selection"
export MSG_SERVICE_SELECTED="✅ Service successfully selected:"

# -----------------------------------------------------------------------------
# Environment / variable errors
# -----------------------------------------------------------------------------
export MSG_ERROR_ENV_NOT_SET="⚠️ Environment variable is not set!"
export MSG_ERROR_AWS_NOT_SET="⚠️ AWS variable is not set!"
export MSG_TARGET_FILE_NOT_FOUND="📂 Target file '%s' not found"
export MSG_MISSING_REQ_VAR="⚠️ Missing required variable: %s"
export MSG_MISSING_VAR="⚠️ Missing variable: %s"

# -----------------------------------------------------------------------------
# Authentication / AWS messages
# -----------------------------------------------------------------------------
export MSG_AUTHENTICATION_FAILED="❌ Authentication failed for service: %s"
export MSG_CREDENTIAL_ALREADY_SET="🔑 AWS credentials already set for service: %s"
export MSG_AUTHENTICATION_SUCCESSFULLY="✅ Authenticated successfully for service: %s"
export MSG_AUTH_SUCCESS="🎉 Authentication successful."

# -----------------------------------------------------------------------------
# Session / connection messages
# -----------------------------------------------------------------------------
export MSG_SESSION_STARTED="🚀 SSM session started."
export MSG_CONFIRM_CONNECT="🔗 Do you want to connect now? [Y/n] "
export MSG_TOKEN_VALIDITY="⏱ Token valid for 15 minutes."
export MSG_ABORTED="🛑 Aborted"
export MSG_DISCONNECTED="⚡ Disconnected from %s"

# -----------------------------------------------------------------------------
# Service / DB info
# -----------------------------------------------------------------------------
export MSG_SERVICE="🛠 Service"
export MSG_DB="🗄 DB Name"
export MSG_USER="👤 User"
export MSG_CONNECT="🔌 Connect? [Y/n] "
export MSG_COMMAND="💻 Command"
