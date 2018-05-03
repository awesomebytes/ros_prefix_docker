#!/bin/bash
set -ve
# Need to have Docker logged in (docker login)

image_id=$(docker images | grep ros_prefix_kinetic_ros_base | awk '{print $1}')

docker tag $image_id awesomebytes/ros_prefix_kinetic_ros_base:latest

docker push awesomebytes/ros_prefix_kinetic_ros_base
