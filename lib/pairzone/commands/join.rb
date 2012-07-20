require 'tempfile'

module Pairzone
  module Commands
    class Join
      def initialize(pairzone_name, identity)
        @pairzone_name = pairzone_name
        @identity = File.expand_path(identity)
      end

      def execute
        pairzone = Pairzone::Instance.find_by_project_name(@pairzone_name)
        if (pairzone.nil?)
          Logger.error("No pairzone exists with the name '#{@pairzone_name}'.")
        else
          pairzone.connect(@identity)
        end
      end
    end
  end
end
