#!/usr/bin/env bash

export IMAGE_NAME=$1
echo $PATH
which docker-compose

/usr/local/bin/docker-compose down -v
/usr/local/bin/docker-compose -f docker-compose.yaml up -d
echo "success"