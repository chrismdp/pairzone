require 'spec_helper'

describe Pairzone::PairzoneLifecycle do
  subject { stub(:lifecycle, create: unstarted, find_by_project_name: started).extend(Pairzone::PairzoneLifecycle) }
  let(:unstarted) { mock(:pairzone, name: 'pairzone', collaborators: [], ip: '', status: 'unstarted') }
  let(:started) { mock(:pairzone, name: 'pairzone', collaborators: [], ip: '', status: 'started') }

  before do
    subject.start_wait_interval = 0
  end

  context "starting" do
    it "calls create" do
      subject.should_receive(:create) { unstarted }
      subject.start({})
    end

    it "blocks, calling find_by_project_name until the state is started" do
      subject.should_receive(:find_by_project_name).with(unstarted.name).
        exactly(5).times.
        and_return(unstarted, unstarted, unstarted, unstarted, started)
      subject.start({})
    end
  end
end

