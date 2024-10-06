.PHONY: help
.DEFAULT_GOAL := help

ignore: ## Create .gitignore file
	git ignore visualstudiocode direnv terraform macos python > .gitignore

help: ## Show options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
