require 'spec_helper'

describe Pairzone::CloudCredentials do
  let(:config_directory) { double }
  subject { Pairzone::CloudCredentials.new(config_directory) }

  before do
    File.stub(:read) { <<-FILE.undent
      ---
      ec2:
        access_key: 12a3456
        secret_access_key: abcdef
      FILE
    }
  end

  context "already given" do
    it "loads them from the config directory" do
      subject.access_key.should == '12a3456'
      subject.secret_access_key.should == 'abcdef'
    end
  end
  context "not already found" do
    it "asks the session for them"
  end
end

