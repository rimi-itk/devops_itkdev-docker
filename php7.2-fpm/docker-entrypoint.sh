#!/bin/bash
set -e  

## Run templates with configuration.
/usr/local/bin/confd --onetime --backend env --confdir /etc/confd

# Add docker host domain to hosts file
if [ ! -z "${DOCKER_HOST_DOMAIN}" ]; then
  echo $(getent hosts host.docker.internal | cut -d" " -f1) ${DOCKER_HOST_DOMAIN} >> /etc/hosts
fi

## Start the php FPM process.
echo "Starting PHP 7.2 FPM"
php-fpm7.2 -F --pid /var/run/php/php-fpm7.2.pid -y /etc/php/7.2/fpm/php-fpm.conf