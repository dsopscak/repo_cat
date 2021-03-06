#!/usr/bin/env bash

SETUP_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo $SETUP_HOME

. $SETUP_HOME/secrets

sudo subscription-manager register \
    --username $RH_USER --password $RH_PASSWORD --auto-attach

sudo dnf update

# Stuff needed for installing and enabling use of rbenv. 
sudo dnf install -y git curl \
    bison gcc make bzip2 openssl-devel libyaml-devel libffi-devel \
    readline-devel zlib-devel gdbm-devel ncurses-devel

