#!/bin/bash
set -e  

## Run templates with configuration.
/usr/local/bin/confd --onetime --backend env --confdir /etc/confd

## Start the php FPM process.
echo "Starting PHP 5.6 FPM"
php-fpm5.6 -F --pid /var/run/php/php-fpm5.6.pid -y /etc/php/5.6/fpm/php-fpm.conf