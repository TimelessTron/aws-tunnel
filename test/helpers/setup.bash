load_mocks() {
  export APP_DIR=/app
  export SCRIPT_DIR="$APP_DIR/scripts"

  export TEST_DIR="/test"
  mkdir -p "$TEST_DIR/.aws"
  export TARGET_FILE="$TEST_DIR/.aws/selected_service"
  export AUTH_ENV_FILE="$TEST_DIR/.aws/aws_env.sh"

  load "$APP_DIR/test/helpers/bats-libs/bats-support/load.bash"
  load "$APP_DIR/test/helpers/bats-libs/bats-assert/load.bash"

  source "$SCRIPT_DIR/lang/_test.sh"
  source "$APP_DIR/test/helpers/mocks/exportService_mock"
}
