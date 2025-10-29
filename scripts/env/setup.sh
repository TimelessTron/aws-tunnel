#!/usr/bin/env bash
set -euo pipefail

# Make sure the directory exists
[ -d /app/.aws ] || mkdir -p /app/.aws

# Create files if they don't exist
[ -f /app/.aws/aws_env.sh ] || touch /app/.aws/aws_env.sh
[ -f /app/.aws/selected_service ] || touch /app/.aws/selected_service
