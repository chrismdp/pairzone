module Pairzone
  class CloudCredentials < Struct.new(:config_directory, :credentials_source)
    attr :access_key, :secret_access_key

    def initialize(*args)
      super(*args)
      if File.exists?(cloud_credentials_file)
        read_config
      else
        ask_for_config
        save_config
      end
    end

    private

    def read_config
      config = YAML.load(File.read(cloud_credentials_file))
      @access_key = config['ec2']['access_key']
      @secret_access_key = config['ec2']['secret_access_key']
    end

    def ask_for_config
      keys = credentials_source.ec2_keys
      @access_key = keys[:access_key]
      @secret_access_key = keys[:secret_access_key]
    end

    def save_config
      File.open(cloud_credentials_file, "w") do |file|
        file.write(YAML.dump({ 'ec2' => { 'access_key' => @access_key, 'secret_access_key' => @secret_access_key }}))
      end
    end

    def cloud_credentials_file
      config_directory + "/cloud_credentials.yml"
    end
  end
end
