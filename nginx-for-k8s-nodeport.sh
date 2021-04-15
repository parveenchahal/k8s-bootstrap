sudo apt install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo tee /etc/nginx/nginx.conf <<EOF
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
    worker_connections 768;
}

stream {
    server {
        listen 80;
        proxy_pass localhost:30080;
    }

    server {
        listen 443;
        proxy_pass localhost:30443;
    }
}
EOF
sudo nginx -s reload
