#!/usr/bin/env bash
set -euo pipefail

[ -d /app/.aws ] || mkdir -p /app/.aws
: >/app/.aws/aws_env.sh
: >/app/.aws/selected_service
