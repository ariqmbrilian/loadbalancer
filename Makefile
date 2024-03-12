.PHONY: build start stop

build:
	docker build -t application application/

start-caddy:
	docker compose -f caddy/docker-compose.yml up -d

stop-caddy:
	docker compose -f caddy/docker-compose.yml down

start-nginx:
	docker compose -f nginx/docker-compose.yml up -d

stop-nginx:
	docker compose -f nginx/docker-compose.yml down

clean:
	docker compose -f caddy/docker-compose.yml down
	docker compose -f nginx/docker-compose.yml down
	docker system prune -af
	docker volume prune -f
