# ROS Prefix Docker
This repo contains the different Dockerfiles to build the ROS Prefix stuff incrementally.

ROS Prefix allows you to extract a full ROS distro (ROS Kinetic right now) into a folder and be dropped into a shell with access to all of it (and it's dependencies) without touching your OS (without any privileges required).

# Already made images
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

* `ros_prefix_kinetic_ros_extended_1`: Builds on top of `ros_prefix_kinetic_ros_base` the [ros-overlay]() emerging `ros-kinetic/navigation`, `ros-kinetic/rosbridge_suite`, `ros-kinetic/image_common` & `ros-kinetic/image_transport_plugins` .
```bash
docker pull awesomebytes/ros_prefix_kinetic_ros_extended_1
```


TODO: Create a docker that creates a layer for every package emerged based on the dependency tree.

# Test it yourself
For example, to run rosbrige on a machine that has nothing installed.

(Note that there is work in progress to make this just a single command, but it's not ready yet).

Get the `ros_prefix_kinetic_ros_extended_1` image:

```bash
docker pull awesomebytes/ros_prefix_kinetic_ros_extended_1
```

Run the docker with a shared folder to be able to copy stuff out of it:
```bash
docker run -it -v $HOME:/shared awesomebytes/ros_prefix_kinetic_ros_extended_1
```

In the shell in the Docker create a .tar.gz of the Gentoo Prefix + ROS overlay (from now on ROS Prefix) and copy it to your host:
```bash
cd /tmp
# This will take a couple of minutes, the file will become around 3GB
tar cvzf ros_prefix.tar.gz gentoo
cp ros_prefix.tar.gz /shared
```

Now you can exit the Docker container shell and extract the `ros_prefix.tar.gz`:
```bash
# Exit the Docker container
exit
# Extract wherever you want the .tar.gz
tar xvf ros_prefix.tar.gz
```

Now you can get into the ROS Prefix environment (which knows nothing of your OS by default, that can be changed) (there are scripts to automate this too, but it's a work in progress):
```bash
# Softlink trick so we can deploy this .tar.gz in any machine
ln -s ~/gentoo /tmp/gentoo
cd gentoo
# Hacky workaround so the username of the current user is the same in the Gentoo Prefix
cp /etc/group /tmp/gentoo/etc/group
cp /etc/passwd /tmp/gentoo/etc/passwd
# Get into ROS Prefix shell!
./startprefix
# Do ROS stuff
source /tmp/gentoo/opt/ros/kinetic/setup.bash
export ROS_IP=127.0.0.1
roslaunch rosbridge_server rosbridge_websocket.launch
```

Then you can install any ROS library (wich will be built from source) with:
```bash
emerge --ask ros-kinetic/ROS_PACKAGE_NAME
```

TODO: Create and document binary packaging.