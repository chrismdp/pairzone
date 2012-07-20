module Pairzone
  class Instance
    def to_str
      "<%= color('This Pairzone: #{name}', CYAN + BOLD) %>\nOwner:         #{owner}\nCollaborators: #{collaborators.join(', ')}"
    end

    def connect(identity)
      Logger.info("Connecting to Pairzone...")
      shell(identity).run(%{ssh -i #{identity} -t pairzone@#{ip} "/usr/local/bin/pairzone-tmux.sh"})
    end

    def push_code(identity)
      Logger.debug("pushing local code to pairzone instance")
      shell(identity).remote(ip, "git init #{project_name} &&
          cd #{project_name} &&
          git config receive.denyCurrentBranch ignore")
          shell(identity).git("git push --mirror #{git_location}")
          shell(identity).remote(ip, "cd #{project_name} && git reset --hard")
    end

    def fetch_code(identity)
      shell(identity).git "git fetch #{git_location} master:pairzone"
      Logger.info("Your git code has been placed in a local 'pairzone' branch. To merge this code into your HEAD, run this commmand:\n\ngit merge pairzone")
    end

    def shell(identity)
      @shell ||= Shell.new(identity)
    end

    def git_location
      "pairzone@#{ip}:#{project_name}"
    end
  end
end
