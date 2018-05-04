# This image builds on the bootstrapped
# Ubuntu 16.04 Gentoo Prefix on /tmp/gentoo
# with ros-kinetic/ros_base and builds more
# ros-kinetic packages
FROM awesomebytes/ros_prefix_kinetic_ros_base:latest

USER rosuser

RUN $PREFIXED emerge ros-kinetic/navigation

RUN $PREFIXED emerge ros-kinetic/rosbridge_suite

WORKDIR $EPREFIX/usr/lib
RUN ln -s libboost_python-2.7.so libboost_python.so
WORKDIR /home/rosuser

RUN $PREFIXED emerge ros-kinetic/image_common

# image_transport_plugins needs some new use rules
COPY --chown=rosuser:rosuser package.use $EPREFIX/etc/portage

RUN $PREFIXED emerge ros-kinetic/image_transport_plugins


# Create the bin packages
RUN $PREFIXED quickpkg "*/*" --include-config y --include-unmodified-config y

ENTRYPOINT ["/bin/bash"]
