require 'fog'

module Pairzone
  class Curator < Struct.new(:project_name, :cloud_credentials, :identity)
    attr_accessor :start_wait_interval
    DEFAULT_START_WAIT_INTERVAL = 5

    def start(options)
      Logger.info("Starting Pairzone for project '#{project_name}'...")
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
      end
      Logger.info("Pairzone booted: ip address #{pairzone.ip}")
      pairzone
    end
  end
end
