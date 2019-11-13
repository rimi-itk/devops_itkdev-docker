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

## Start the php FPM process.
echo "Starting PHP 5.6 FPM"
php-fpm5.6 -F --pid /var/run/php/php-fpm5.6.pid -y /etc/php/5.6/fpm/php-fpm.conf
