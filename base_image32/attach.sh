#!/bin/bash

echo "Guessing running container name for ros_prefix_base_image32..."
running_name=$(docker ps | grep ros_prefix_base_image32 | awk '{print $NF}')
echo "Found running name: $running_name"
echo "Attaching..."
docker exec -it $running_name /bin/bash
