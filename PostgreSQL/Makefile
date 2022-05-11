#!/bin/bash

.PHONY: start
start:
	@docker-compose -f docker-compose.yml up

.PHONY: stop
stop:
	@docker-compose -f docker-compose.yml stop

.PHONY: bash
bash:
	@docker-compose -f docker-compose.yml run db bash

.PHONY: connect-db
connect-db:
	@docker-compose -f docker-compose.yml run db psql -u
