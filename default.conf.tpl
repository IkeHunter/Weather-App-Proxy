server {
    listen ${CLIENT_PORT};
    
    location / {
        root /vol/client;
        index index.html index.htm;
    }
    error_page 404 =200 /index.html;
}

server {
    listen ${LISTEN_PORT};
    
    location /static {
        alias /vol/static;
    }
    
    location / {
        uwsgi_pass           ${APP_HOST}:${APP_PORT};
        include              /etc/nginx/uwsgi_params;
        client_max_body_size 10M;
    }
}

