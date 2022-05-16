#!/bin/bash

# Run sql file
# 7dbs=# \i create-structure.sql

GET_DOCKER_ID_COMMAND=$(shell docker ps -aqf "name=postgresql_db_1")

.PHONY: start
start:
	@docker-compose -f docker-compose.yml up

.PHONY: stop
stop:
	@docker-compose -f docker-compose.yml stop

.PHONY: bash
bash:
	$(eval DOCKER_ID=$(GET_DOCKER_ID_COMMAND))
	@docker exec -it $(DOCKER_ID) bash

.PHONY: connect-db
connect-db:
	$(eval DOCKER_ID=$(GET_DOCKER_ID_COMMAND))
	@docker exec -it $(DOCKER_ID) psql -U postgres postgres
