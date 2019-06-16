#!/bin/bash

docker build --no-cache --tag=itkdev/ .
docker push itkdev/mariadb
