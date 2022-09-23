#!/bin/bash

# Run sql file
# 7dbs=# \i create-structure.sql

GET_DOCKER_ID_COMMAND=$(shell docker ps -aqf "name=hbase_hbase-master_1")

.PHONY: justwork
justwork:
	@docker-compose -f docker-compose.yml up --build -d

.PHONY: start
start:
	@docker-compose -f docker-compose.yml up -d

.PHONY: stop
stop:
	@docker-compose -f docker-compose.yml stop

.PHONY: bash
bash:
	$(eval DOCKER_ID=$(GET_DOCKER_ID_COMMAND))
	@docker exec -it $(DOCKER_ID) bash

.PHONY: connect-db
connect-db:
	@docker-compose -f docker-compose.yml exec hbase-master hbase shell
