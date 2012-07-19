require 'spec_helper'

describe Pairzone::Authenticate do
  describe "key retrieval" do
    let(:config) { "config-file-location" }
    let(:auth_server) { mock }
    let(:key) { 'key' }

    it "retrieves the key from a file if it already exists" do
      File.stub(exist?: true)
      File.should_receive(:read).and_return(key)
      Pairzone::Authenticate.retrieve_key(config, auth_server).should == key
    end

    context "connecting to server" do

      let(:username) { 'username' }
      let(:password) { 'password' }
      let(:user) { mock(:user, authentication_token: key) }
      
      before do
        File.stub(exist?: false)
        Pairzone::Logger.stub(:ask).and_return(username, password)
        Pairzone::Api::Base.stub(:connect_to).with(auth_server, username: username, password: password, default: false)
        Pairzone::Api::User.stub(:current_user).and_return(user)
        # Collaborators
        FileUtils.stub(:mkdir_p)
        File.should_receive(:open)
      end

      it "asks the user if the file does not exist" do
        Pairzone::Authenticate.retrieve_key(config, auth_server).should == key
      end

      it "asks for username and password again if it fails the first time" do
        Pairzone::Api::Base.stub(:connect_to).exactly(2).times
        Pairzone::Logger.should_receive(:ask).exactly(4).times.and_return("wrong", "wrong", username, password)
        Pairzone::Api::User.stub(:current_user).and_return(nil, user)

        Pairzone::Authenticate.retrieve_key(config, auth_server).should == key
      end
    end
  end
end
