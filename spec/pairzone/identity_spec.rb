require 'spec_helper'

describe Pairzone::Identity do
  subject { Pairzone::Identity.new(config_directory) }

  context "already generated" do
    it "loads the identity from the config directory" do
      pending
    end
  end

  context "when missing" do
    it "generates a new keypair"
  end
end
