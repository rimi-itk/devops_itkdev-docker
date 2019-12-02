#!/bin/bash
set -e

## Run templates with configuration.
/usr/local/bin/confd --onetime --backend env --confdir /etc/confd

## Start the perl fcgi process.
/usr/sbin/fcgiwrap -s tcp:0.0.0.0:9000 -f
