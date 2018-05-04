# ROS Prefix Docker
This repo contains the different Dockerfiles to build the ROS Prefix stuff.

# base_image
* `ros_prefix_base_image`: Contains a Ubuntu 16.04 with some build tools installed.
```bash
docker pull awesomebytes/ros_prefix_base_image
```

* `ros_prefix_bootstrapped_image`: Builds on top of `ros_prefix_base_image` a Gentoo Prefix environment on /tmp/gentoo.
```bash
docker pull awesomebytes/ros_prefix_bootstrapped_image
```

* `ros_prefix_kinetic_ros_base`: Builds on top of `ros_prefix_bootstrapped_image` the [ros-overlay](https://github.com/ros/ros-overlay) emerging `ros-kinetic/ros_base`.
```bash
docker pull awesomebytes/ros_prefix_kinetic_ros_base
```

TODO: More advanced emerging of ROS packages
