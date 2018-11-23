# This image builds on the base one that's just Ubuntu 16.04 32bits
# with a user called rosuser and some build tools
# extending it to do the bootstrapping of Gentoo Prefix
# on /tmp/gentoo
FROM awesomebytes/ros_prefix_base_image32:latest

USER root
RUN apt-get update
RUN apt-get install wget -y
# All these flags are needed to compile 32bit on a 64bit kernel
ENV CHOST i686-pc-linux-gnu
ENV CXXFLAGS -m32
ENV CFLAGS -m32
ENV LDFLAGS -m32

USER rosuser

RUN wget https://gitweb.gentoo.org/repo/proj/prefix.git/plain/scripts/bootstrap-prefix.sh
RUN chmod +x bootstrap-prefix.sh

# To avoid gcc 8.2.0-r4 failing compiling
RUN mkdir -p /tmp/gentoo/etc/portage/
RUN echo ">sys-devel/gcc-7.3.0-r3" >> /tmp/gentoo/etc/portage/package.mask
RUN mkdir -p /tmp/gentoo/etc/portage/
RUN echo "dev-lang/perl-5.26.2 -berkdb" >> /tmp/gentoo/etc/portage/package.use

# Give answers to the interactive bootstrapper
# and keep a log of how long it took
RUN date > start_bootstrap_date.txt && \
echo "Y\n\
\n\
/tmp/gentoo\n\
luck\n" | ./bootstrap-prefix.sh && date > end_bootstrap_date.txt

# Create the .tar.gz
# RUN cd /tmp && tar cvzf /home/rosuser/gentoo_bootstrapped_on_tmp.tar.gz gentoo


ENTRYPOINT ["/bin/bash"]
