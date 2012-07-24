require 'highline/import'

module Pairzone
  class Asker
    def ec2_keys
      $stdout.puts "Please enter your EC2 credentials; you can find them by heading to https://portal.aws.amazon.com/gp/aws/securityCredentials and signing in."
      {
        :access_key => $stdout.ask("Access Key ID:") {|q| q.echo = "*" },
        :secret_access_key => $stdout.ask("Secret Access Key:") {|q| q.echo = "*" }
      }
    end
  end
end
