.DEFAULT_GOAL := default

IMAGE ?= docker.cluster.fun/averagemarcus/megasync:latest

export DOCKER_CLI_EXPERIMENTAL=enabled

.PHONY: test # Run all tests, linting and format checks
test: lint check-format run-tests

.PHONY: lint # Perform lint checks against code
lint:
	@echo "⚠️ 'lint' unimplemented"

.PHONY: check-format # Checks code formatting and returns a non-zero exit code if formatting errors found
check-format:
	@echo "⚠️ 'check-format' unimplemented"

.PHONY: format # Performs automatic format fixes on all code
format:
	@echo "⚠️ 'format' unimplemented"

.PHONY: run-tests # Runs all tests
run-tests:
	@echo "⚠️ 'run-tests' unimplemented"

.PHONY: fetch-deps # Fetch all project dependencies
fetch-deps:
	@echo "⚠️ 'fetch-deps' unimplemented"

.PHONY: build # Build the project
build: lint check-format fetch-deps
	@echo "⚠️ 'build' unimplemented"

.PHONY: docker-build # Build the docker image
docker-build:
	@docker buildx create --use --name=crossplat --node=crossplat && \
	docker buildx build \
		--output "type=docker,push=false" \
		--tag $(IMAGE) \
		.

.PHONY: docker-publish # Push the docker image to the remote registry
docker-publish:
	@docker buildx create --use --name=crossplat --node=crossplat && \
	docker buildx build \
		--output "type=image,push=true" \
		--tag $(IMAGE) \
		.

.PHONY: docker-publish-arm # Build and push the armhf image (needs to be built on ARM hardware)
docker-publish-arm:
	@docker buildx create --use --name=crossplat --node=crossplat && \
	docker buildx build \
		--file Dockerfile.armhf \
		--platform linux/arm/7 \
		--output "type=image,push=true" \
		--tag $(IMAGE)-armhf \
		.

.PHONY: run # Run the application
run:
	@echo "⚠️ 'run' unimplemented"

.PHONY: ci # Perform CI specific tasks to perform on a pull request
ci:
	@echo "⚠️ 'ci' unimplemented"

.PHONY: release # Release the latest version of the application
release:
	@echo "⚠️ 'release' unimplemented"

.PHONY: help # Show this list of commands
help:
	@echo "megasync"
	@echo "Usage: make [target]"
	@echo ""
	@echo "target	description" | expand -t20
	@echo "-----------------------------------"
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1	\2/' | expand -t20

default: test build
