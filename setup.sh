#!/usr/bin/env bash

SETUP_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo $SETUP_HOME

. $SETUP_HOME/secrets

sudo subscription-manager register \
    --username $RH_USER --password $RH_PASSWORD --auto-attach

sudo dnf update

# Stuff needed for installing and enabling use of rbenv. 
sudo subscription-manager repos --enable=codeready-builder-for-rhel-8-x86_64-rpms
sudo dnf install -y git curl \
    bison gcc make bzip2 openssl-devel libyaml-devel libffi-devel \
    readline-devel zlib-devel gdbm-devel ncurses-devel

sudo useradd repocat -m
if [[ -d $SETUP_HOME/ssh ]]; then
    sudo su repocat -c "cp -r $SETUP_HOME/ssh ~repocat/.ssh"
    sudo su repocat -c "cp ~repocat/.ssh/id_rsa.pub ~repocat/.ssh/authorized_keys"
    sudo chmod 700 ~repocat/.ssh
    sudo chmod 644 ~repocat/.ssh/id_rsa.pub
    sudo chmod 600 ~repocat/.ssh/id_rsa ~repocat/.ssh/authorized_keys
fi

sudo su repocat -c "curl -sL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash -"
sudo su repocat -c "echo 'export PATH=\"\$HOME/.rbenv/bin:\$PATH\"' >> ~/.bashrc"
sudo su repocat -c "echo 'eval \"\$(rbenv init -)\"' >> ~/.bashrc"
sudo su - repocat -c "rbenv install 2.7.2"
sudo su - repocat -c "rbenv global 2.7.2"
