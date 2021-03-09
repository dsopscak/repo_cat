#!/usr/bin/env bash

set -x -e

. $HOME/.repocat/config.env

GIT_URL=$1
KEY_FILE=$2

tokens=(${GIT_URL//\// })
REPO=$(echo ${tokens[-1]} | cut -d "." -f 1)
GIT_HOST=$(echo ${tokens[0]} | cut -d ":" -f 1 | cut -d "@" -f 2)


ssh -p $PORT -i $KEY $USER@$HOST mkdir repos/$REPO

ssh -p $PORT -i $KEY $USER@$HOST \
    ssh-keygen -F $GIT_HOST \|\| ssh-keyscan $GIT_HOST \>\> \~/.ssh/known_hosts

scp -P $PORT -i $KEY $KEY_FILE $USER@$HOST:~/repos/$REPO/keyfile

ssh -p $PORT -i $KEY $USER@$HOST \
    ssh-agent bash -c \'ssh-add \~/repos/$REPO/keyfile \; \
    git -C \~/repos clone --bare $GIT_URL\'
