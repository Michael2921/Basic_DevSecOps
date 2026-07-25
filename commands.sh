#!/usr/bin/env bash

export IMAGE_NAME=$1
echo $PATH
whoami
which docker-compose

docker-compose down -v
docker-compose -f docker-compose.yaml up -d
echo "success"