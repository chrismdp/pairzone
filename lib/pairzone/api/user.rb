module Pairzone
  module Api
    class User < Base
      property :email
      property :username
      property :authentication_token

      connect :current_user, :get => '/user'

      def to_str
        "Username:      #{username}\n" +
        "Email:         #{email}"
      end
    end
  end
end
