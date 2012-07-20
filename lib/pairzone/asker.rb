require 'highline/import'

module Pairzone
  class Asker
    def access_key
      $stdout.ask("What is your AWS access key?") {|q| q.echo = "*" }
    end

    def secret_access_key
      $stdout.ask("What is your AWS secret access key?") {|q| q.echo = "*" }
    end
  end
end
