.PHONY: build install bash server

build:
	docker-compose build

install:
	docker-compose run --rm web mix deps.get

bash:
	docker-compose run --rm web bash

# dbsetup:
# 	docker-compose run --rm web bundle exec rails db:setup

server:
	docker-compose run --rm --service-ports web

# console:
# 	docker-compose run --rm web bundle exec rails console
