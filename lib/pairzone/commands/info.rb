module Pairzone
  module Commands
    class Info
      def initialize(project_name)
        @project_name = project_name
      end

      def execute
        Logger.info("<%= color('Pairzone Account Information', CYAN + BOLD) %>")
        Logger.info("TO BE COMPLETED")
      end
    end
  end
end
