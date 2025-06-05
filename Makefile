.DEFAULT_GOAL := help
.SILENT:

.PHONY: help run build clean test console

help:  ## Show this help message
	echo "Available commands:"
	grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

run: ## To start an tunnel and a session
	docker compose run --rm aws-tunnel

build: ## Build the container
	docker compose build --no-cache --pull

clean:
	docker compose down --rmi local -v

test: ## Run the tests
	docker compose run --rm bats

console c: ## Start a console
	docker compose run --rm console
