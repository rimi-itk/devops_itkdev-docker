#!/bin/bash

docker build --no-cache --tag=itkdev/mariadb .
docker push itkdev/mariadb
