# repocat.rb
#
# Preliminary library for repocat 

require 'net/ssh'
require 'net/scp'

load "#{ENV['HOME']}/.repocat/config.rb"

module RepoCat

  def self.init git_remote, key_file

    repo = git_remote.split("/").last.split(".").first

    Net::SSH.start(HOST, USER, keys: KEYS, port: PORT) do |ssh|
      result = ssh.exec!("mkdir #{repo}")
      puts "#{result.exitstatus}: #{result}"
    end

  end


end


