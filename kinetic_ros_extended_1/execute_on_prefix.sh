#!/tmp/gentoo/bin/bash
# Copyright 2006-2014 Gentoo Foundation; Distributed under the GPL v2
# $Id: startprefix.in 61219 2012-09-04 19:05:55Z grobian $

# Fabian Groffen <grobian@gentoo.org> -- 2007-03-10
# Enters the prefix environment by starting a login shell from the
# prefix.  The SHELL environment variable is elevated in order to make
# applications that start login shells to work, such as `screen`.

# if you come from a substantially polluted environment (another
# Prefix), a cleanup as follows resolves most oddities I've ever seen:
# env -i HOME=$HOME TERM=$TERM USER=$USER $SHELL -l
# hence this script starts the Prefix shell like this

# What is our prefix?
EPREFIX="/tmp/gentoo"

if [[ ${SHELL#${EPREFIX}} != ${SHELL} ]] ; then
    echo "You appear to be in prefix already (SHELL=$SHELL)" > /dev/stderr
    exit -1
fi

# not all systems have the same location for shells, however what it
# boils down to, is that we need to know what the shell is, and then we
# can find it in the bin dir of our prefix
SHELL=${SHELL##*/}
# set the prefix shell in the environment
export SHELL=${EPREFIX}/bin/${SHELL}
# check if the shell exists
if [[ ! -x $SHELL ]] ; then
    echo "Failed to find the Prefix shell, this is probably" > /dev/stderr
    echo "because you didn't emerge the shell ${SHELL##*/}" > /dev/stderr
    exit -1
fi

# give a small notice
# echo "Entering Gentoo Prefix ${EPREFIX}"
# start the login shell, clean the entire environment but what's needed
RETAIN="HOME=$HOME TERM=$TERM USER=$USER SHELL=$SHELL"
# PROFILEREAD is necessary on SUSE not to wipe the env on shell start
[[ -n ${PROFILEREAD} ]] && RETAIN+=" PROFILEREAD=$PROFILEREAD"
# ssh-agent is handy to keep, of if set, inherit it
[[ -n ${SSH_AUTH_SOCK} ]] && RETAIN+=" SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
# if we're on some X terminal, makes sense to inherit that too
[[ -n ${DISPLAY} ]] && RETAIN+=" DISPLAY=$DISPLAY"
# do it!

# Build the parameters
# Pass the parameters to the prefixed shell
echo "Executing on prefixed environment:"
echo "$*"
env -i $RETAIN $SHELL -lc "$*"
