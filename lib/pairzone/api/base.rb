require 'party_resource'
require 'json'

module Pairzone
  module Api
    class Base
      include PartyResource

      def initialize(data)
        Logger.debug("Received DATA: #{data}")
        populate_properties(data.values.first)
      end

      def self.connect_to(host, options)
        params = {
          base_uri: host,
          headers: {
            'Accept' => 'application/json',
            'User-agent' => 'pairzone-gem/' + VERSION
          }
        }.merge(options)
        Logger.debug("Connecting to API server with params: #{params.inspect}")
        PartyResource::Connector.add(:pairzone, params)
      end
    end
  end
end
