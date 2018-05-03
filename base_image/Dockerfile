# Just Ubuntu 16.04 with a user called rosuser and some basic tools
FROM ubuntu:16.04

RUN apt-get update

# Create user
RUN apt-get install apt-utils sudo -y
RUN useradd --create-home --shell=/bin/bash rosuser
RUN chown -R rosuser /home/rosuser/
RUN chmod -R o-w /etc/sudoers.d/
WORKDIR /home/rosuser/

# Instal basic stuff
RUN apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential -y

# Nice tools to have
RUN apt-get install bash-completion nano net-tools less iputils-ping vim emacs -y
RUN apt-get install python-pip python-dev  -y

USER rosuser

ENTRYPOINT ["/bin/bash"]
