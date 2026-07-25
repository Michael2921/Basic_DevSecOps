#!/usr/bin/env bash

export IMAGE_NAME=$1
"docker-compose down -v"
"docker-compose -f docker-compose.yaml up -d"
echo "success"