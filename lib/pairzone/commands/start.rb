require 'net/ssh'
require 'tempfile'

module Pairzone
  module Commands
    class Start
      def initialize(project_name, identity, options)
        @project_name = project_name
        @identity = File.expand_path(identity)
        @options = options
      end

      def execute
        @pairzone = Pairzone::Api::Pairzone.start(:project_name => @project_name, :collaborators => collaborators)
        @pairzone.push_code(@identity)
        unless @options[:background]
          @pairzone.connect(@identity)
          @pairzone.fetch_code(@identity)
        end
      end

      private

      def collaborators
        return (@options[:c] || "").split(',')
      end
    end
  end
end
