#!/bin/bash

# Get the container ID for Mangata container
container_id=$(docker ps | awk '$2 ~ /mangata/ {print $1}')

# Check if container_id is not empty
if [ -n "$container_id" ]; then
  echo "Found Mangata container with ID: $container_id"
  # Follow the logs of the Mangata container
  docker logs -f "$container_id"
else
  echo "Mangata container not found."
fi
