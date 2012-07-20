require 'net/ssh'
require 'tempfile'

module Pairzone
  module Commands
    class Start < Struct.new(:project_name, :cloud_credentials, :identity)
      def execute
        curator = Pairzone::Curator.new(project_name, cloud_credentials, identity)
        pairzone = curator.start(:project_name => project_name)
        pairzone.push_code
        unless options[:background]
          pairzone.connect
          pairzone.fetch_code
        end
      end
    end
  end
end
