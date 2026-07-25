#!/usr/bin/env bash

export IMAGE_NAME=$1
echo $PASS | docker login -u $USER --password-stdin
docker-compose down -v
docker-compose -f docker-compose.yaml up -d
echo "successsss"