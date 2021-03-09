#!/usr/bin/env ruby
#

require_relative 'repocat.rb'

RepoCat.init 'git@github.com:dsopscak/provision-helper.git',
             '/home/sops01/.ssh/rsa_git'
