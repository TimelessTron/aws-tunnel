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
export MSG_TARGET_FILE_NOT_FOUND="📂 Target file not found"
export MSG_MISSING_REQ_VAR="⚠️ Missing required variable: "
export MSG_MISSING_VAR="⚠️ Missing variable: "

# -----------------------------------------------------------------------------
# Authentication / AWS messages
# -----------------------------------------------------------------------------
export MSG_NEW_REGION_RECONNECT="Detected change in REGION or ROLE — re-authenticating..."
export MSG_NO_SERVICE_JUMBHOST="No running EC2 jumphost found in region"
export MSG_AUTHENTICATION_FAILED="❌ Authentication failed for service: "
export MSG_CREDENTIAL_ALREADY_SET="🔑 AWS credentials already set for service: "
export MSG_AUTHENTICATION_SUCCESSFULLY="✅ Authenticated successfully for service: "
export MSG_AUTH_SUCCESS="🎉 Authentication successful."
export MSG_REFRESH_AWS_CREDENTIALS="Refreshing AWS credentials..."
export MSG_CONNECTION_FAILED_AFTER_REFRESH="Connection failed after authentication refresh"

# -----------------------------------------------------------------------------
# Session / connection messages
# -----------------------------------------------------------------------------
export MSG_STARTING_JUMBHOST="Starting SSM session via jumphost"
export MSG_SESSION_STARTED="🚀 SSM session started."
export MSG_TOKEN_VALIDITY="⏱ Token valid for 15 minutes."
export MSG_ABORTED="🛑 Aborted"
export MSG_DISCONNECTED="⚡ Disconnected from "

# -----------------------------------------------------------------------------
# Service / DB info
# -----------------------------------------------------------------------------
export MSG_SERVICE="🛠 Service"
export MSG_DB="🗄 DB Name"
export MSG_USER="👤 User"
export MSG_COMMAND="💻 Command"
