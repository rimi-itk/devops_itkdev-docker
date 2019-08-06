#!/bin/bash

## Run templates with configuration.
/usr/local/bin/confd --onetime --backend env --confdir /etc/confd

## Run parent entry point.
/usr/local/bin/docker-entrypoint.sh mysqld 