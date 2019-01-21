# Docker
This repos contains the setup to build docker images for ITK-dev.

See https://hub.docker.com/search?q=itkdev&type=image

## Drush6
Drush 6 image with memcached support enabled.

```sh
docker build --tag=itkdev/drush6 .
```

## PHP 7.0 FPM

```sh
docker build --tag=itkdev/php7.0-fpm .
```

