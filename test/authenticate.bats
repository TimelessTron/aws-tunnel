#!/usr/bin/env bats

load '/app/test/helpers/setup.bash'

setup() {
  load_mocks # lädt $APP_DIR, $SCRIPT_DIR, lang, exportService_mock

  # Test‐Umgebung vorbereiten

  # Setze Umgebungsvariablen wie in realer Umgebung:
  export USER="testuser"
  export PASS="testpass"
  export ORGANIZATION="testorg"
  export SERVICE_REGION="eu-central-1"
  export SERVICE_ROLE="test-role"
  export RSEVICE_NAME="TestService"

  # Simuliere Farben (leer, damit set -u nicht meckert)
  export ERROR_COLOR=""
  export SUCCESS_COLOR=""
  export NC=""

  export TEST_DIR="/test"
  mkdir -p "$TEST_DIR/.aws"
  export TARGET_FILE="$TEST_DIR/.aws/selected_service"
  touch $TARGET_FILE
  export AUTH_ENV_FILE="$TEST_DIR/.aws/aws_env.sh"
  : >$AUTH_ENV_FILE
}

@test "Exit 0 if AWS credentials already set" {
  export AWS_ACCESS_KEY_ID="EXISTING_ID"
  export AWS_SECRET_ACCESS_KEY="EXISTING_SECRET"
  export AWS_SESSION_TOKEN="EXISTING_TOKEN"

  source "$SCRIPT_DIR/auth/authenticate.sh"
  run authenticate_service

  assert_success
  assert_output --partial "AWS credentials already set"
}

@test "Successful authentication writes ENV file" {
  export PATH="$APP_DIR/test/helpers/mocks:$PATH"
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN

  source "$SCRIPT_DIR/auth/authenticate.sh"
  run authenticate_service

  assert_success
  [[ -f "$AUTH_ENV_FILE" ]] || fail "Auth file not created"
  run grep '^export AWS_ACCESS_KEY_ID="MOCK_ID"$' "$AUTH_ENV_FILE"
  assert_success
  run grep '^export AWS_SECRET_ACCESS_KEY="MOCK_SECRET"$' "$AUTH_ENV_FILE"
  assert_success
  run grep '^export AWS_SESSION_TOKEN="MOCK_TOKEN"$' "$AUTH_ENV_FILE"
  assert_success
}

@test "Failure if aws-okta-processor fails" {
  export PATH="$APP_DIR/test/helpers/mocks-fail:$PATH"

  source "$SCRIPT_DIR/auth/authenticate.sh"
  run authenticate_service

  assert_failure
  assert_output --partial "Authentication failed"
}

@test "Failure if AWS credentials still missing after authenticate" {
  export PATH="$APP_DIR/test/helpers/mocks-empty:$PATH"

  source "$SCRIPT_DIR/auth/authenticate.sh"
  run authenticate_service

  assert_failure
  assert_output --partial "MSG_ERROR_AWS_NOT_SET"
}
