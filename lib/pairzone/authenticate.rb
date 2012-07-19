require 'fileutils'
require 'highline'

module Pairzone
  class Authenticate
    def self.retrieve_key(config, server)
      @api_key_location = "#{config}/authentication_token"
      Logger.debug("retrieving pairzone key")
      Logger.debug("checking for file #{@api_key_location}")
      if (File.exist?(@api_key_location))
        key = key_from_file
      else
        key = key_from_server(server)
      end
      Logger.debug("api key discovered '#{key}'")
      key
    end

    def self.key_from_file
      File.read(@api_key_location).strip
    end

    def self.key_from_server(server)
      Logger.info "<%= color('Hello, welcome to Pairzone.', CYAN + BOLD) %>"
      Logger.info "We need some information so we can tie this computer to your account."
      user = nil
      begin
        email = Logger.ask("Pairzone email: ")
        password = Logger.ask("Pairzone password: ") { |q| q.echo = "." }

        Pairzone::Api::Base.connect_to(server, username: email, password: password, default: false)
        Logger.debug("Retrieving key from server with supplied credentials")
        user = Pairzone::Api::User.current_user
        unless user
          Logger.info "Cannot authenticate: please try again."
        end
      end while user.nil?
      save_token(@api_key_location, user.authentication_token)
      user.authentication_token
    end

    def self.save_token(location, token)
      FileUtils.mkdir_p(File.dirname(location))
      Logger.debug("Saving API key to #{location}")
      File.open(location, "w") do |f|
        f.puts(token)
      end
    end

  end
end
