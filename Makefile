DUNE = opam exec -- dune

.PHONY: help
help: ## Print this help message
	@echo "List of available make commands";
	@echo "";
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}';
	@echo "";

.PHONY: build
build: ## Build the project, including non installable libraries and executables
	@$(DUNE) build @all

.PHONY: build-prod
build-prod: ## Build for production (--profile=prod)
	@$(DUNE) build --profile=prod @@default

.PHONY: dev
dev: ## Build in watch mode
	@$(DUNE) build -w @@default

.PHONY: clean
clean: ## Clean artifacts
	@$(DUNE) clean

.PHONY: jest
jest: ## Run the jest unit tests
	@npx jest

.PHONY: jest-watch
jest-watch: ## Run the jest unit tests in watch mode
	@npx jest --watch

.PHONY: jest-devtools
jest-devtools: ## Run the jest unit tests in watch mode
	@echo "open Chrome and go to chrome://inspect"
	@node --inspect-brk node_modules/.bin/jest --runInBand --detectOpenHandles

.PHONY: test
test: ## Run the runtests from dune (snapshot)
	@$(DUNE) build @runtest

.PHONY: test-watch
test-watch: ## Run the unit tests in watch mode
	@$(DUNE) build @runtest -w

.PHONY: test-promote
test-promote: ## Updates snapshots and promotes it to correct
	@$(DUNE) build @runtest --auto-promote

.PHONY: format
format: ## Format the codebase with ocamlformat
	@$(DUNE) build @fmt --auto-promote

.PHONY: format-check
format-check: ## Checks if format is correct
	@$(DUNE) build @fmt

.PHONY: install
install: ## Update the package dependencies when new deps are added to dune-project
	@opam install . --deps-only --with-test --with-dev-setup
	@npm install --force

.PHONY: init
create-switch: ## Create a local opam switch
	@opam switch create . 5.2.0 --no-install

.PHONY: init
init: create-switch install ## Create a local opam switch, install deps

.PHONY: demo-watch
demo-watch: ## Build the demo in watch mode
	@$(DUNE) build @melange-app --watch

.PHONY: demo-serve
demo-serve: ## Build the demo and serve it
	npx http-server -p 8080 _build/default/demo/
