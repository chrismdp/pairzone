module Pairzone
  module Commands
    class Info
      def initialize(project_name)
        @project_name = project_name
      end

      def execute
        Logger.info("<%= color('Pairzone Account Information', CYAN + BOLD) %>")
        @user = Pairzone::Api::User.current_user
        Logger.info(@user)
        Logger.info("")
        Logger.debug("Finding information about local pairzone: #{local_pairzone_name}")
        pairzone = Pairzone::Api::Pairzone.find_by_project_name(local_pairzone_name)
        Logger.info(pairzone || "No pairzone found for this directory (create one with <%= color('pairzone create', CYAN) %>).")
      end

      private

      def local_pairzone_name
        "#{@user.username}-#{@project_name}"
      end
    end
  end
end
