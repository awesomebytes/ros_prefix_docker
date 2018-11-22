# This image builds on the base one that's just Ubuntu 16.04 32bits
# with a user called rosuser and some build tools
# extending it to do the bootstrapping of Gentoo Prefix
# on /tmp/gentoo
FROM awesomebytes/ros_prefix_base_image32:latest

USER root
RUN apt-get update
RUN apt-get install wget -y

USER rosuser

RUN wget https://gitweb.gentoo.org/repo/proj/prefix.git/plain/scripts/bootstrap-prefix.sh
RUN chmod +x bootstrap-prefix.sh

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
