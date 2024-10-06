.PHONY: lint fmt help test lock setup
.DEFAULT_GOAL := help

PORT ?= 8000
LOG_LEVEL ?= debug
GCP_PROJCT_ID ?= ${CLOUDSDK_ACTIVE_CONFIG_NAME}
IMAGE_NAME := us-central1-docker.pkg.dev/${GCP_PROJCT_ID}/logging/logging

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

build: ## Build the image
	docker build --tag=${IMAGE_NAME}:dev \
		--platform linux/amd64 \
		--target=deploy .
	docker push ${IMAGE_NAME}:dev

list: ## List images
	gcloud artifacts docker images list ${IMAGE_NAME}

show-latest-image: ## Get the latest digest
	./scripts/fetch-latest-image.sh ${IMAGE_NAME}

setup: ## Setup the project
	uv sync

run-dev: ## Run the app dev via uvicorn
	uv run uvicorn --app-dir=src main:app --port ${PORT} --log-level ${LOG_LEVEL} --reload

test-cloud-run: ## Test the cloud run
	curl -H "Authorization: Bearer $(gcloud auth print-identity-token)"

# https://cloud.google.com/run/docs/troubleshooting#missing-auth-token
proxy-cloud-run: ## Proxy the cloud run
	gcloud run services proxy logging --project=${GCP_PROJCT_ID} --region=us-central1 --port=9091

help: ## Show options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
