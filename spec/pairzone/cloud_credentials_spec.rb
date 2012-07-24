require 'spec_helper'

describe Pairzone::CloudCredentials do
  let(:config_directory) { "foo" }
  let(:credentials_source) { double }
  let(:contents) { <<-FILE.undent
    ---
    ec2:
      access_key: 12a3456
      secret_access_key: abcdef
    FILE
  }

  subject { Pairzone::CloudCredentials.new(config_directory, credentials_source) }

  context "already given" do
    before do
      File.stub(:exists? => true)
      File.stub(:read => contents)
    end

    it "loads them from the config directory" do
      subject.access_key.should == '12a3456'
      subject.secret_access_key.should == 'abcdef'
    end
  end

  context "not already found" do
    before do
      File.stub(:exists? => false)
      credentials_source.stub(:ec2_keys) {{ :access_key => "12a3456", :secret_access_key => "abcdef" }}
      File.stub(:open)
    end

    it "asks the session for them" do
      credentials_source.should_receive(:ec2_keys) {{ :access_key => "foobar", :secret_access_key => "bazquux" }}
      subject.access_key.should == "foobar"
      subject.secret_access_key.should == "bazquux"
    end

    it "saves the credentials for next time" do
      file = double
      file.should_receive(:write).with(contents)
      File.should_receive(:open).with(config_directory + "/cloud_credentials.yml", "w").and_yield(file)
      subject
    end
  end
end

