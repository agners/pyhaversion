.DEFAULT_GOAL := help

help: ## Shows this help message
	@printf "\033[1m%s\033[36m %s\033[32m %s\033[0m \n\n" "Development environment for" "ludeeus/pyhaversion" "";
	@awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m make %-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST);
	@echo

requirements: ## Install requirements
	@python3 -m pip --disable-pip-version-check install -r requirements.txt

test: ## Run all tests
	@python3 -m pytest tests -rxf -x -v -l --cov=./ --cov-report=xml

black: ## Lint all files black
	@python3 -m black --fast pyhaversion tests

coverage: ## Check the coverage of the package
	@python3 -m pytest tests -rxf -x -v -l --cov=./ --cov-report=xml > /dev/null
	@coverage report