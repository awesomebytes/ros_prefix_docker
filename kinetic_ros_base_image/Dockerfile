# This image builds on the bootstrapped
# Ubuntu 16.04 Gentoo Prefix on /tmp/gentoo
# and adds ros-kinetic/ros_base
FROM awesomebytes/ros_prefix_bootstrapped_image:latest

USER rosuser

# We need to do this before any command that deal with gentoo prefix:
ENV EPREFIX=/tmp/gentoo

# All commands to run in the Gentoo Prefix environment must
# be preprended by $PREFIXED
ADD execute_on_prefix.sh /tmp/execute_on_prefix.sh
ENV PREFIXED=/tmp/execute_on_prefix.sh

# By default it's python3 (option 1)
# Choosing Python 2.7
RUN $PREFIXED eselect python set 2


# Emerging git
RUN $PREFIXED emerge dev-vcs/git

RUN echo "Setting EAPI to 6 as explained in http://wiki.ros.org/Installation/Gentoo"
RUN mkdir -p $EPREFIX/etc/portage/profile/
RUN echo "6" > $EPREFIX/etc/portage/profile/eapi

RUN echo "Setting up ros-overlay https://github.com/ros/ros-overlay"
RUN mkdir -p $EPREFIX/etc/portage/repos.conf
RUN echo "[ros-overlay]\n\
location = $EPREFIX/usr/local/portage\n\
sync-type = git\n\
sync-uri = https://github.com/ros/ros-overlay\n\
auto-sync = yes\n\
masters = gentoo" > $EPREFIX/etc/portage/repos.conf/ros-overlay.conf

# Sync ros-overlay
RUN $PREFIXED emaint sync -r ros-overlay

# Add package.use package.mask and patches
# that hopefully will get fixed upstream with time
# so we don't need them
COPY etc/* $EPREFIX/etc/portage


# Until https://bugs.gentoo.org/654678 is fixed we need this
ADD patches/log4cxx-0.10.0-r1.ebuild $EPREFIX/usr/portage/dev-libs/log4cxx/log4cxx-0.10.0-r1.ebuild
WORKDIR $EPREFIX/usr/portage/dev-libs/log4cxx
RUN $PREFIXED ebuild log4cxx-0.10.0-r1.ebuild manifest

# Until https://github.com/ros/ros-overlay/pull/605 is merged we need this
ADD patches/force-nondeb-layout.patch $EPREFIX/usr/local/portage/ros-kinetic/catkin/files
WORKDIR $EPREFIX/usr/local/portage/ros-kinetic/catkin
RUN $PREFIXED ebuild catkin-* manifest

# Until https://github.com/ros/ros-overlay/pull/606 is merged we need this
ADD patches/ros-cmake.eclass $EPREFIX/usr/local/portage/eclass

WORKDIR $EPREFIX
# echo "Setup the basic ROS"
RUN date > ros_base_start.txt \
    && $PREFIXED  emerge ros-kinetic/ros_base \
    && date > ros_base_end.txt

ENTRYPOINT ["/bin/bash"]
