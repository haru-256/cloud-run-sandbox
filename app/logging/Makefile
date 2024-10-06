.PHONY: lint fmt help test lock setup
.DEFAULT_GOAL := help

PORT ?= 8000
LOG_LEVEL ?= debug
GCP_PROJCT_ID ?= ${CLOUDSDK_ACTIVE_CONFIG_NAME}

lint: ## Run Linter
	uv run ruff check .
	uv run mypy .

fmt: ## Run formatter
	uv run ruff check --fix .
	uv run ruff format .

test: ## Run tests
	uv run pytest .

lock: ## Lock dependencies
	uv lock

# TODO: change image tag for clooud run
build: ## Build the image
	docker build --tag=us-central1-docker.pkg.dev/${GCP_PROJCT_ID}/logging/logging:dev \
		--target=deploy .
	docker push us-central1-docker.pkg.dev/${GCP_PROJCT_ID}/logging/logging:dev

setup: ## Setup the project
	uv sync

run-dev: ## Run the app dev via uvicorn
	uv run uvicorn --app-dir=src main:app --port ${PORT} --log-level ${LOG_LEVEL} --reload

help: ## Show options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
