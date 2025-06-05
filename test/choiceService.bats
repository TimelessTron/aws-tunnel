#!/usr/bin/env bats

load "/app/test/helpers/setup.bash"

setup() {
  load_mocks
  echo "load mocks done"
  # Simuliere benötigte ENV
  ##  export SERVICES="DEV"
  ##  export DEV_NAME="DevService"
  ##  export DEV_REGION="eu-central-1"
  ##  export DEV_ROLE="some-role"
  ##  export DEV_SSM_TARGET="target-id"
  ##  export DEV_SSM_DOCUMENT_NAME="doc"
  ##  export DEV_SSM_HOST="host"
  ##  export DEV_SSM_HOST_PORT="1234"
  ##  export DEV_SSM_CLIENT_PORT="5678"

  # Testverzeichnis vorbereiten
  export TEST_DIR="/test"
  mkdir -p "$TEST_DIR/.aws"
  export TARGET_FILE="$TEST_DIR/.aws/selected_service"
  export AUTH_ENV_FILE="$TEST_DIR/.aws/aws_env.sh"

  # Simuliere Farben
  #  export COLOR=""
  #  export SUCCESS_COLOR=""
  #  export ERROR_COLOR=""
  #  export NC=""
  #  export LENG=de

}
teardown() {
  #rm -rf "$TEST_TMP"
  ls /test
}

@test "valid selection stores selected service" {
  source "$APP_DIR/scripts/service/choose.sh"
  run select_service <<<"1"

  assert_success

  [[ -f "$TARGET_FILE" ]]
  assert_success

  run cat $TARGET_FILE
  assert_output "DEV"
}

@test "invalid selection exits with error" {
  source "$APP_DIR/scripts/service/choose.sh"
  run select_service <<<"99"

  assert_failure
  assert_output --partial "MSG_CHOOSE_SERVICE"
}

@test "missing required env var fails" {
  unset DEV_REGION
  source "$APP_DIR/scripts/service/choose.sh"
  run select_service <<<"1"

  assert_failure
  assert_output --partial "MSG_ERROR_ENV_NOT_SET"
}
