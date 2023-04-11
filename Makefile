DUNE = opam exec -- dune

.PHONY: help
help: ## Print this help message
	@echo "List of available make commands";
	@echo "";
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}';
	@echo "";

.PHONY: build
build: ## Build the project, including non installable libraries and executables
	@$(DUNE) build @@default

.PHONY: build-prod
build-prod: ## Build for production (--profile=prod)
	@$(DUNE) build --profile=prod @@default

.PHONY: dev
dev: ## Build in watch mode
	@$(DUNE) build -w @@default

.PHONY: clean
clean: ## Clean artifacts
	@$(DUNE) clean

.PHONY: test
test: ## Run the unit tests
	@$(DUNE) build @runtest
	@npx jest

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
	@opam install . --deps-only --with-test
	@npm install

# Those pins are necessary until melange is released on opam and dune 3.8 is released
.PHONY: pin
pin: ## Pin melange and dune
	@opam pin add dune "https://github.com/ocaml/dune.git#a5fd306a4e24c7bd67330b411b3e5662b7e03039" -y
	@opam pin add melange "https://github.com/melange-re/melange.git#3df98795a3aa3c2488bee48e3e5d3da198c03860" -y

.PHONY: init
create-switch: ## Create a local opam switch
	@opam switch create . 4.14.1 --no-install

.PHONY: init
init: create-switch install pin ## Create a local opam switch, install deps and pin dependencies
