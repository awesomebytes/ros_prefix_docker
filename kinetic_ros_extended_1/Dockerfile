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

# To advance we need to
WORKDIR $EPREFIX/etc/portage
RUN echo "# required by dev-ruby/power_assert-1.1.1::gentoo[-test,ruby_targets_ruby25]\\n
# required by dev-lang/ruby-2.3.7::gentoo\\n
# required by dev-ruby/xmlrpc-0.3.0::gentoo[ruby_targets_ruby23]\\n
# required by dev-lang/ruby-2.5.1::gentoo\\n
# required by dev-ruby/rdoc-6.0.1::gentoo[ruby_targets_ruby25]\\n
>=virtual/rubygems-14 ruby_targets_ruby25\\n
# required by dev-lang/ruby-2.5.1::gentoo\\n
# required by dev-ruby/rdoc-6.0.1::gentoo[ruby_targets_ruby25]\\n
# required by dev-lang/ruby-2.3.7::gentoo[rdoc]\\n
# required by dev-ruby/power_assert-1.1.1::gentoo[ruby_targets_ruby23]\\n
# required by dev-ruby/test-unit-3.2.7::gentoo[ruby_targets_ruby23]\\n
>=dev-ruby/json-2.1.0 ruby_targets_ruby25\\n
# required by dev-lang/ruby-2.5.1::gentoo\\n
# required by dev-ruby/rdoc-6.0.1::gentoo[ruby_targets_ruby25]\\n
# required by dev-lang/ruby-2.3.7::gentoo[rdoc]\\n
# required by dev-ruby/power_assert-1.1.1::gentoo[ruby_targets_ruby23]\\n
# required by dev-ruby/test-unit-3.2.7::gentoo[ruby_targets_ruby23]\\n
>=dev-ruby/net-telnet-0.1.1-r1 ruby_targets_ruby25\\n
# required by dev-lang/ruby-2.5.1::gentoo\\n
# required by dev-ruby/rdoc-6.0.1::gentoo[ruby_targets_ruby25]\\n
# required by dev-lang/ruby-2.3.7::gentoo[rdoc]\\n
# required by dev-ruby/power_assert-1.1.1::gentoo[ruby_targets_ruby23]\\n
>=dev-ruby/test-unit-3.2.7 ruby_targets_ruby25\\n
# required by dev-qt/qtwebkit-5.9.1::gentoo\\n
# required by sci-libs/vtk-8.1.0-r1::gentoo[qt5]\\n
# required by ros-kinetic/opencv3-3.3.1-r5::ros-overlay\\n
# required by ros-kinetic/cv_bridge-1.12.8::ros-overlay\\n
# required by ros-kinetic/theora_image_transport-1.9.5::ros-overlay\\n
# required by ros-kinetic/image_transport_plugins-1.9.5::ros-overlay\\n
# required by ros-kinetic/image_transport_plugins (argument)\\n
>=dev-qt/qtcore-5.9.5 icu\\n
# required by dev-lang/ruby-2.5.1::gentoo\\n
# required by dev-ruby/rdoc-6.0.1::gentoo[ruby_targets_ruby25]\\n
# required by dev-lang/ruby-2.3.7::gentoo[rdoc]\\n
# required by dev-ruby/power_assert-1.1.1::gentoo[ruby_targets_ruby23]\\n
# required by dev-ruby/test-unit-3.2.7::gentoo[ruby_targets_ruby23]\\n
>=dev-ruby/minitest-5.11.3 ruby_targets_ruby25\\n
# required by virtual/rubygems-14::gentoo[ruby_targets_ruby25]\\n
# required by dev-qt/qtwebkit-5.9.1::gentoo\\n
# required by sci-libs/vtk-8.1.0-r1::gentoo[qt5]\\n
# required by ros-kinetic/opencv3-3.3.1-r5::ros-overlay\\n
# required by ros-kinetic/cv_bridge-1.12.8::ros-overlay\\n
# required by ros-kinetic/theora_image_transport-1.9.5::ros-overlay\\n
# required by ros-kinetic/image_transport_plugins-1.9.5::ros-overlay\\n
# required by ros-kinetic/image_transport_plugins (argument)\\n
>=dev-ruby/rubygems-2.7.6 ruby_targets_ruby25\\n
" >> package.use
WORKDIR /home/rosuser

RUN $PREFIXED emerge ros-kinetic/image_transport_plugins


# Create the bin packages
RUN $PREFIXED quickpkg "*/*" --include-config y --include-unmodified-config y

ENTRYPOINT ["/bin/bash"]
