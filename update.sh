#!/bin/bash

echo "Pull git changes.."
git pull

echo "MoneySaver stopping..."
docker-compose down

echo "Pull MS changes..."
docker-compose pull

echo "Staring MoneySaver..."
./start.sh