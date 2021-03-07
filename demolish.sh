#!/usr/bin/env bash

# Give back Redhat subsciprtion foo
#
sudo subscription-manager remove --all
sudo subscription-manager unregister
sudo subscription-manager clean
