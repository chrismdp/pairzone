module Pairzone
  class Shell
    def initialize(identity)
      @identity = identity
    end

    def run(cmd)
      Logger.debug(cmd)
      output = `#{cmd}`
      Logger.debug("#=> #{output}")
      output
    end

    def git(cmd)
      git_ssh = Tempfile.new('git_ssh')
      git_ssh.puts %{#!/bin/bash\nexec ssh -i #{@identity} $1 "bash --login -c '$2'"}
      git_ssh.close
      `chmod +x #{git_ssh.path}`
      run "GIT_SSH='#{git_ssh.path}' #{cmd}"
    end

    def remote(ip, command)
      output = ''
      remote_log(ip, command)
      Net::SSH.start(ip, 'pairzone', :auth_methods => ['publickey'], :keys => [@identity]) do |ssh|
        output = (ssh.exec!("bash --login -c '#{command}'") || "").strip
      end
      remote_log(ip, "#=> #{output}")
      return output
    end

    def remote_log(ip, msg)
      Logger.debug("<%= color('[pairzone@#{ip}]:', CYAN + BOLD) %> #{msg}")
    end


  end
end
