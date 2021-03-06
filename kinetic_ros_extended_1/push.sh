#!/bin/bash
set -ve
# Need to have Docker logged in (docker login)

image_id=$(docker images | grep ros_prefix_kinetic_ros_extended_1 | awk '{print $1}')

docker tag $image_id awesomebytes/ros_prefix_kinetic_ros_extended_1:latest

docker push awesomebytes/ros_prefix_kinetic_ros_extended_1
