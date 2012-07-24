require 'spec_helper'

describe Pairzone::Curator do
  let(:identity) { double(:private_key_path => "", :public_key_path => "") }
  let(:cloud_credentials) { double.as_null_object }
  let(:server) { double }
  let(:connection) { double.as_null_object }
  subject { Pairzone::Curator.new("project-name", cloud_credentials, identity) }

  before do
    Fog::Compute.stub(:new => connection)
  end

  context "not yet started" do
    it "starts a pairzone" do
      connection.should_receive(:bootstrap).with(
        :private_key_path => identity.private_key_path,
        :public_key_path => identity.public_key_path,
        :username => 'ubuntu').and_return(server)
      subject.start
    end

  end
end

