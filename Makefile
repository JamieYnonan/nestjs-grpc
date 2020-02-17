.DEFAULT_GOAL := help

USERNAME_LOCAL = "$(shell whoami)"
UID_LOCAL = "$(shell id -u)"
GID_LOCAL = "$(shell id -g)"

TIME_ZONE ?= America/Lima

CLI_IMAGE = auth_cli
CLI_VERSION = 1.0.0
APP_IMAGE = auth_app
APP_VERSION = 0.1.0


build_cli_image: ## Build cli image: make build_cli_image
	docker build --force-rm --rm \
		--build-arg VERSION=${CLI_VERSION} \
		--build-arg TIME_ZONE=${TIME_ZONE} \
		-t ${CLI_IMAGE}:${CLI_VERSION} docker/cli

npm_cli: ## Execute npm: make npm_cli EXTRA_FLAGS="-e NODE_ENV=production" COMMAND="run build"
	docker run --rm -it \
		-v $$PWD/app:/app \
		-w="/app" ${EXTRA_FLAGS} \
		auth_cli:1.0.0 sh -c "npm --no-cache ${COMMAND}"

build_app_image: ## Build app image: make build_app_image
	docker build --force-rm --rm \
		--build-arg VERSION=${APP_VERSION} \
		--build-arg TIME_ZONE=${TIME_ZONE} \
		-t ${APP_IMAGE}:${APP_VERSION} -f docker/app/Dockerfile .

up: build_app_image ## Up application: make up
	IMAGE=${APP_IMAGE}:${APP_VERSION} \
	docker-compose -f docker/docker-compose.yml up -d --build

down:
	IMAGE=${APP_IMAGE}:${APP_VERSION} \
	docker-compose -f docker/docker-compose.yml down

## Help ##
help:
	@printf "\033[31m%-25s %-50s %s\033[0m\n" "Target" "Help" "Usage"; \
	printf "\033[31m%-25s %-50s %s\033[0m\n" "------" "----" "-----"; \
	grep -hE '^\S+:.*## .*$$' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-25s\033[0m %-49s \033[34m%s\033[0m\n", $$1, $$2, $$3}'