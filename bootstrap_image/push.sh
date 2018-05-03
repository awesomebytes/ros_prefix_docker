#!/bin/bash
set -ve
# Need to have Docker logged in (docker login)

image_id=$(docker images | grep ros_prefix_bootstrapped_image | awk '{print $1}')

docker tag $image_id awesomebytes/ros_prefix_bootstrapped_image:latest

docker push awesomebytes/ros_prefix_bootstrapped_image
