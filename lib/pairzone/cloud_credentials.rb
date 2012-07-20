module Pairzone
  class CloudCredentials < Struct.new(:config_directory)
    attr :access_key, :secret_access_key

    def initialize(*args)
      super(*args)
      read_config
    end

    def read_config
      config = YAML.load(File.read(config_directory, "r"))
      @access_key = config['ec2']['access_key']
      @secret_access_key = config['ec2']['secret_access_key']
    end
  end
end
