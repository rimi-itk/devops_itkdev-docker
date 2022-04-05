#!/bin/sh
set -e

# Add docker host domain to hosts file
if [ ! -z "${DOCKER_HOST_DOMAIN}" ]; then
  echo $(getent hosts host.docker.internal | cut -d" " -f1) ${DOCKER_HOST_DOMAIN} >> /etc/hosts
fi

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

## Add mailhog options to capture mails from PHP.
if [ ! -z "${PHP_MAILHOG_ENABLE}" ]; then
  echo "sendmail_path = '/usr/local/bin/mhsendmail --smtp-addr=\"${PHP_MAILHOG_SERVER}:${PHP_MAILHOG_PORT}\"'" >> ${PHP_INI_DIR}/../php-fpm.d/zz-fpm-docker.conf
  echo "sendmail_path = '/usr/local/bin/mhsendmail --smtp-addr=\"${PHP_MAILHOG_SERVER}:${PHP_MAILHOG_PORT}\"'" >> ${PHP_INI_DIR}/conf.d/20-php.ini
fi

## Start the php FPM process.
echo "Starting PHP 7.0 FPM"
/usr/local/bin/docker-php-entrypoint php-fpm
