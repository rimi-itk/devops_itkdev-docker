# Docker
This repos contains the setup to build docker images for ITK-dev.

See https://hub.docker.com/search?q=itkdev&type=image

## Drush6
Drush 6 image with memcached support enabled.

```sh
docker build --tag=itkdev/drush6 .
```

### Alias
```sh
alias ddrush='docker-compose run --rm drush'
```

## PHP 7.0 FPM

```sh
docker build --tag=itkdev/php7.0-fpm .
```

## Composer example
```yml
version: "2"

services:
  mariadb:
    image: mariadb:10.3
    ports:
      - '3306'
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_USER: db
      MYSQL_PASSWORD: db
      MYSQL_DATABASE: db

  phpfpm:
    image: itkdev/php7.0-fpm:latest
    restart: always
    depends_on:
      - mariadb
    volumes:
      - .:/app

  nginx:
    image: bitnami/nginx:latest
    depends_on:
      - phpfpm
      - memcached
    ports:
      - '8000'
    volumes:
      - ./docker/vhost.conf:/opt/bitnami/nginx/conf/vhosts/ereolen.conf:ro
      - ./:/app

  memcached:
    image: 'memcached:latest'
    ports:
      - '11211'
    environment:
      - MEMCACHED_CACHE_SIZE=64

  drush:
    image: itkdev/drush6
    depends_on:
      - mariadb
    entrypoint:
      - drush
    volumes:
      - ./:/app
```
