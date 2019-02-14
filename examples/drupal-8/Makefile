PROJECT := drupal-8
DNS := ${PROJECT}.docker.localhost

up:
	docker-compose -p ${PROJECT} pull
	docker-compose -p ${PROJECT} up -d

down:
	docker-compose -p ${PROJECT} down

stop:
	docker-compose -p ${PROJECT} stop

ps:
	docker-compose -p ${PROJECT} ps

clean:
	docker-compose -p ${PROJECT} rm

shell:
	docker-compose -p ${PROJECT} exec phpfpm bash

mysql:
	docker-compose -p ${PROJECT} port mariadb 3306 | cut -d: -f2

url:
	@echo http://${DNS}:$(shell docker-compose -p ${PROJECT} port reverse-proxy 80 | cut -d: -f2)
