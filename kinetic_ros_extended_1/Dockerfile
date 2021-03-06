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
# need to just tell the system udev-init-scripts-32 is satisfied
RUN echo "sys-fs/udev-init-scripts-32\n" >> $EPREFIX/etc/portage/profile/package.provided
RUN $PREFIXED emerge sys-fs/udev-init-scripts

RUN echo "en_US.UTF-8 UTF-8" >> $EPREFIX/etc/locale.gen
RUN $PREFIXED locale-gen
RUN $PREFIXED LANG=en_US.UTF-8 emerge -1 dev-ruby/rdoc

RUN $PREFIXED emerge dev-qt/qttest
RUN $PREFIXED emerge dev-qt/qtconcurrent

RUN $PREFIXED emerge ros-kinetic/image_transport_plugins

RUN $PREFIXED emerge ros-kinetic/ddynamic_reconfigure_python

RUN $PREFIXED emerge ros-kinetic/image_pipeline



# Create the bin packages
RUN $PREFIXED quickpkg "*/*" --include-config y --include-unmodified-config y

ENTRYPOINT ["/bin/bash"]
