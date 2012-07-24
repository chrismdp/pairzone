require 'fog'

module Pairzone
  class Curator < Struct.new(:project_name, :cloud_credentials, :identity)
    def start
      server = connection.servers.bootstrap(
        :private_key_path => identity.private_key_path,
        :public_key_path => identity.public_key_path,
        :username => 'ubuntu'
      )
    end

    private
    def connection
      @connection ||= Fog::Compute.new(
        :provider => 'AWS',
        :aws_access_key_id => cloud_credentials.access_key,
        :aws_secret_access_key => cloud_credentials.secret_access_key
      )
    end
  end
end
