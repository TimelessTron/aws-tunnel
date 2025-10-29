.DEFAULT_GOAL := help
.SILENT:

.PHONY: help run build clean console print_mysql

help:  ## Show this help message
	echo "Available commands:"
	grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

run: ## To start an tunnel and a session
	docker compose run --rm aws-tunnel

build: ## Build the container
	docker compose build --no-cache --pull

clean: ## Remove image and network
	docker compose down --rmi local -v

console: ## Start a console
	docker compose run --rm console

print: ## Print out your mysql command
	docker compose run --rm print

connect: ## Connect to mysql DB
	docker compose run --rm connect
