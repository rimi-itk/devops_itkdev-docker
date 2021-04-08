#!/bin/bash
set -e

# Add docker host domain to hosts file
if [ ! -z "${DOCKER_HOST_DOMAIN}" ]; then
  echo $(getent hosts host.docker.internal | cut -d" " -f1) ${DOCKER_HOST_DOMAIN} >> /etc/hosts
fi

# Set xdebug remote host to docker host ip.
if [ ! -z "${PHP_XDEBUG}" ]; then
  export PHP_XDEBUG_REMOTE_HOST=$(getent hosts host.docker.internal | cut -d" " -f1)
fi

## Run templates with configuration.
/usr/local/bin/confd --onetime --backend env --confdir /etc/confd

## Set selected composer version. Default version 1.
if [ ! -z "${COMPOSER_VERSION}" ]; then
  if [ "${COMPOSER_VERSION}" = "1" ]; then
    ln -fs /usr/bin/composer1 /usr/local/bin/composer
  else
    ln -fs /usr/bin/composer2 /usr/local/bin/composer
  fi
else
  ln -fs /usr/bin/composer1 /usr/local/bin/composer
fi

## Start the php FPM process.
echo "Starting PHP 5.6 FPM"
php-fpm5.6 -F --pid /var/run/php/php-fpm5.6.pid -y /etc/php/5.6/fpm/php-fpm.conf
