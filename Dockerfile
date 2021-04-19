ARG NODE_VERSION=latest
ARG PHP_VERSION=latest
ARG NGINX_VERSION=1.18.0

FROM node:$NODE_VERSION as npm-build

RUN [ "mkdir", "-p", "/build" ]

WORKDIR /build

RUN [ "npm", "install", "-g", "cross-env" ]


COPY ./src .


RUN [ "npm", "install" ]
RUN [ "npm", "run", "dev" ]

FROM bitnami/php-fpm:$PHP_VERSION as app-build

RUN [ "mkdir", "-p", "/build" ]

WORKDIR /build

COPY --from=npm-build /build .

COPY ./.env .

RUN [ "/opt/bitnami/php/bin/composer",  "install" ]

FROM bitnami/php-fpm:$PHP_VERSION

WORKDIR /app

COPY --from=app-build /build .

EXPOSE 9000

RUN [ "chown", "-R", "daemon:daemon", "/app" ]

RUN [ "chmod", "-R", "+w", "/app/storage" ]

CMD [ "php-fpm", "-F", "--pid", "/opt/bitnami/php/tmp/php-fpm.pid", "-y", "/opt/bitnami/php/etc/php-fpm.conf" ]

