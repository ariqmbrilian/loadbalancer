#!/usr/bin/env bash

set -o errexit

CADDY_COMPOSE_FILE="caddy/docker-compose.yml"
NGINX_COMPOSE_FILE="nginx/docker-compose.yml"


create_vm() {
  cd terraform
  terraform init
  terraform apply -auto-approve
  cd ..
}

delete_vm() {
  cd terraform
  terraform destroy -auto-approve
  rm terraform.state
  cd ..
}

start_caddy() {
  docker build -t application application/
  docker compose -f $CADDY_COMPOSE_FILE up -d
}

stop_caddy() {
  docker compose -f $CADDY_COMPOSE_FILE down --volumes
}

start_nginx() {
  docker build -t application application/
  docker compose -f $NGINX_COMPOSE_FILE up -d
}

stop_nginx() {
  docker compose -f $NGINX_COMPOSE_FILE down --volumes
}

case "$1" in
  create-vm)
    create_vm
    ;;
  delete-vm)
    delete_vm
    ;;
  start-caddy)
    start_caddy
    ;;
  stop-caddy)
    stop_caddy
    ;;
  start-nginx)
    start_nginx
    ;;
  stop-nginx)
    stop_nginx
    ;;
  clean)
    clean
    ;;
  *)
    echo "Usage: $0 {create-vm|delete-vm|start-caddy|stop-caddy|start-nginx|stop-nginx|clean}"
    exit 1
    ;;
esac