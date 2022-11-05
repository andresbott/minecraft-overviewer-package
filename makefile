COMMIT_SHA_SHORT ?= $(shell git rev-parse --short=12 HEAD)
PWD_DIR:= ${CURDIR}
SHELL := /bin/bash

default: help;

# ======================================================================================

prepare: clean
	@mkdir -p ${PWD_DIR}/out

build-bullseye-64: prepare
	@docker build -f targets/bullseye-64/Dockerfile . -t mcoverviewer-builder-bullseye-64
	@docker run -it -v ${PWD_DIR}/out:/out mcoverviewer-builder-bullseye-64:latest /app/targets/bullseye-64/build.sh

build: build-bullseye-64 ## Build all the packages

publish: ## publish the release to github
	@zarf/publish.sh

clean: ## Clean
	@rm -rf ${PWD_DIR}/out

help: ## Show this help
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST)  | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m·%-20s\033[0m %s\n", $$1, $$2}'