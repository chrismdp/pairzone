require 'fileutils'

def config_directory
  "#{File.dirname(__FILE__)}/../pairzone-tmp-config"
end

def tokens
  @tokens ||= {}
end

After do
  FileUtils.rm_rf(config_directory)
end
