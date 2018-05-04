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

# This was never pulled before... but apparently it is now,
# need to patch udev-init-scripts-32
COPY --chown=rosuser:rosuser patches/udev-init-scripts-32.ebuild $EPREFIX/usr/portage/sys-fs/udev-init-scripts
WORKDIR $EPREFIX/usr/portage/sys-fs/
RUN ebuild udev-init-scripts-32.ebuild manifest
WORKDIR /home/rosuser

RUN $PREFIXED emerge ros-kinetic/image_transport_plugins


# Create the bin packages
RUN $PREFIXED quickpkg "*/*" --include-config y --include-unmodified-config y

ENTRYPOINT ["/bin/bash"]
