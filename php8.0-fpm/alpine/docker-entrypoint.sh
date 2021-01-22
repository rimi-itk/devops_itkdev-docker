#!/bin/sh
set -e

# Add docker host domain to hosts file
if [ ! -z "${DOCKER_HOST_DOMAIN}" ]; then
  echo $(getent hosts host.docker.internal | cut -d" " -f1) ${DOCKER_HOST_DOMAIN} >> /etc/hosts
fi

## Set selected composer version. Default version 1.
if [ ! -z "${COMPOSER_VERSION}" ]; then
  if [ "${COMPOSER_VERSION}" = "1" ]; then
    ln -fs /usr/local/bin/composer1 /usr/local/bin/composer
  else
    ln -fs /usr/local/bin/composer2 /usr/local/bin/composer
  fi
else
  ln -fs /usr/local/bin/composer1 /usr/local/bin/composer
fi

## Start the php FPM process.
echo "Starting PHP 8.0 FPM"
/usr/local/bin/docker-php-entrypoint php-fpm
