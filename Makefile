.PHONY: build start stop

build:
	sudo docker build -t application application/

start-caddy:
	sudo docker compose -f caddy/docker-compose.yml up -d

stop-caddy:
	sudo docker compose -f caddy/docker-compose.yml down

start-nginx:
	sudo docker compose -f nginx/docker-compose.yml up -d

stop-nginx:
	sudo docker compose -f nginx/docker-compose.yml down

clean:
	sudo docker compose -f caddy/docker-compose.yml down
	sudo docker compose -f nginx/docker-compose.yml down
	sudo docker system prune -af
	sudo docker volume prune -f
