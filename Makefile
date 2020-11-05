.PHONY:
help:
	@echo Tasks:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


# DEVELOPMENT SETUP
.PHONY:
dev: ## Start next_template development docker containers
	@docker-compose up | sed -En "s/(next_template-dev\\s*(.*)|(Step| --->|Building|Removing|Creating|Successfully))/\1 \2/p"

.PHONY:
clean-dev: ## Stop and remove next_template docker containers and images
	@docker-compose down && \
	docker image rm next_template-dev || true

# LOCAL SETUP
.PHONY:
local: ## Rebuild next_template with Webpack and build local docker containers
	@export ENVIRONMENT=local && \
	./docker/build.sh && ./docker/start.sh


.PHONY:
clean-local: ## Rebuild next_template with Webpack and build local docker containers
	@docker kill next_template || true && docker rm next_template || true && docker image rm next_template || true

