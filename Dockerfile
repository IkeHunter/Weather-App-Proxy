FROM nginxinc/nginx-unprivileged:1-alpine as base
LABEL maintainer="ikehunter.com"

COPY ./default.conf.tpl /etc/nginx/default.conf.tpl
COPY ./uwsgi_params /etc/nginx/uwsgi_params

ENV LISTEN_PORT=8000
ENV APP_HOST=app
ENV APP_PORT=9000
ENV APP_LISTEN_HOST=app
ENV CLIENT_PORT=4200

USER root

COPY ./entrypoint.sh /entrypoint.sh

RUN mkdir -p /vol/static/ && \
    chmod 755 /vol/static/ && \
    touch /etc/nginx/conf.d/default.conf && \
    chown nginx:nginx /etc/nginx/conf.d/default.conf && \
    chmod +x /entrypoint.sh && \
    mkdir -p /vol/client && \
    chown nginx:nginx /vol/client && \
    chmod 755 /vol/client

USER nginx

CMD ["/entrypoint.sh"]
