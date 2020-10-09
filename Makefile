PROJECT_NAME := urlshortener
RUN := run --rm
RAILS_ENV := production

DOCKER_COMPOSE := docker-compose -f docker-compose.yml --project-name $(PROJECT_NAME)
DOCKER_COMPOSE_RUN := $(DOCKER_COMPOSE) $(RUN)

compose_up:
	docker-compose -f docker-compose-dev.yml -p url-shortner up

compose_down:
	docker-compose -f docker-compose-dev.yml -p url-shortner down

prepare: bundle db-create db-migrate

up:
	rm -f tmp/pids/server.pid && ${DOCKER_COMPOSE} up

db-create:
	${DOCKER_COMPOSE_RUN} -e "RAILS_ENV=${RAILS_ENV}" app bundle exec rake db:create

db-migrate:
	${DOCKER_COMPOSE_RUN} -e "RAILS_ENV=${RAILS_ENV}" app bundle exec rake db:migrate

bundle:
	${DOCKER_COMPOSE_RUN} app bundle ${CMD}
