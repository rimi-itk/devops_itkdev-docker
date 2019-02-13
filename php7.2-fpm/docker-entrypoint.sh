#!/bin/bash
set -e  

## Run templates with configuration.
/usr/local/bin/confd --onetime --backend env --confdir /etc/confd

## Start the php FPM process.
echo "Starting PHP 7.2 FPM"
php-fpm7.2 -F --pid /var/run/php/php-fpm7.2.pid -y /etc/php/7.2/fpm/php-fpm.conf