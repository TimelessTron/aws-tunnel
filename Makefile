.DEFAULT_GOAL := help
.SILENT:

.PHONY: help run build clean console print_mysql

# Colors (respect NO_COLOR environment variable)
ifndef NO_COLOR
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
CYAN := \033[0;36m
GRAY := \033[0;37m
NC := \033[0m
endif

## Makefile
help: ## List all available commands
	@printf "$(YELLOW)dev-infra AWS-TUNNEL$(NC)\n"
	@printf "Usage: make aws [TARGET]...\n"
	@printf "Check the README.md for more information about the project.\n"
	@grep -hE '(^[a-zA-Z0-9 \./_-]+:.*?##.*$$)|(^##)|(^###)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; /^## / {printf "\n$(GRAY)%s$(NC)\t\n", substr($$0, 4); }; /^### / {printf "  $(YELLOW)%s$(NC)\t\n", substr($$0, 5)}; /^[a-zA-Z0-9\-\. ]+:.*?##/ { command = $$1; split(command, parts, " "); if (length(parts) > 1) { cmd = parts[1]; for (i = 2; i <= length(parts); i++) { cmd = cmd " ${CYAN}(" parts[i] ")${NC}"; } printf "  ${GREEN}%-25s${NC}\t%s\n", cmd, $$2; } else { printf "  ${GREEN}%-20s${NC}\t%s\n", $$1, $$2; } }'

info: ## print short info about usage
	echo -e "\n${CYAN}"
	@sed -n '/\*\*Example\:\*\*/,/---/p' Readme.md
	echo -e "$(NC)"

## Container
build: ## (Re)Build the container
	docker compose build --no-cache --pull

clean: ## Remove image and network
	docker compose down --rmi local -v

console: ## Start a console
	docker compose run --rm console

## Start Tunnel
run: ## To start an tunnel and a session
	docker compose run --rm aws-tunnel

## Use Services
print: ## Print out your mysql command
	docker compose run --rm print

connect: ## Connect to mysql DB
	docker compose run --rm connect
