Load Balancer round robin performance analysis between nginx and caddy

```
./script.sh create-vm
./script.sh delete-vm
./script.sh start-nginx
./script.sh stop-nginx
./script.sh start-caddy
./script.sh stop-caddy
```

docker build -t -f application/Dockerfile .
docker compose -f nginx/compose.yml up -d
docker compose -f caddy/compose.yml up -d
