module Pairzone
  module PairzoneLifecycle
    attr_accessor :start_wait_interval
    DEFAULT_START_WAIT_INTERVAL = 5

    def start(options)
      Logger.info("Starting Pairzone for project '#{options[:project_name]}'...")
      pairzone = create(:project_name => options[:project_name], :collaborators => options[:collaborators])
      report_starting_status(pairzone)

      wait_for(pairzone)
    end

    def report_starting_status(pairzone)
      Logger.info("Pairzone '#{pairzone.name}' started.")
      pairzone.collaborators.each do |collaborator|
        Logger.info("Collaborator '#{collaborator}' added.")
      end
    end

    def wait_for(pairzone)
      while pairzone.status != 'started' do
        Logger.info("Waiting for pairzone to boot...")
        sleep start_wait_interval || DEFAULT_START_WAIT_INTERVAL
        pairzone = find_by_project_name(pairzone.name)
      end
      Logger.info("Pairzone booted: ip address #{pairzone.ip}")
      pairzone
    end
  end
end
