compose_up:
	docker-compose -f docker-compose-dev.yml -p url-shortner up

compose_down:
	docker-compose -f docker-compose-dev.yml -p url-shortner down
