Load Balancer round robin performance analysis between nginx and caddy

```
./script create-vm
./script delete-vm
./script start-nginx
./script stop-nginx
./script start-caddy
./script stop-caddy
```

docker build -t -f application/Dockerfile .
docker compose -f nginx/compose.yml up -d
docker compose -f caddy/compose.yml up -d