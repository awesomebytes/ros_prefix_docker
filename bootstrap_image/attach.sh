#!/bin/bash

echo "Guessing running container name for ros_prefix_bootstrapped_image..."
running_name=$(docker ps | grep ros_prefix_bootstrapped_image | awk '{print $NF}')
echo "Found running name: $running_name"
echo "Attaching..."
docker exec -it $running_name /bin/bash
