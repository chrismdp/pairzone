require 'spec_helper'

describe Pairzone::Logger do
  let(:stdout) { mock }
  let(:stderr) { mock }

  it "works without first configuring" do
    ->{ Pairzone::Logger.info("foo") }.should_not raise_error
  end

  context "after configuration" do
    before do
      Pairzone::Logger.instance_variable_set(:@stdout, stdout)
      Pairzone::Logger.instance_variable_set(:@stderr, stderr)
    end

    it 'prints output to standard output' do
      msg = 'foo'
      stdout.should_receive(:say).with(msg)
      Pairzone::Logger.info(msg)
    end

    it 'prints debug messages to std error with a prefix' do
      Pairzone::Logger.instance_variable_set(:@level, true)
      stderr.should_receive(:say).with(/debug.*foo/)
      Pairzone::Logger.debug('foo')
    end

    it 'does not print debug messages if they are not turned on' do
      Pairzone::Logger.instance_variable_set(:@level, false)
      stderr.should_not_receive(:say).with(/debug.*foo/)
      Pairzone::Logger.debug('foo')
    end

    it 'prints error messages to std output' do
      msg = 'foo'
      stdout.should_receive(:say).with(/error.*foo/)
      Pairzone::Logger.error(msg)
    end
  end
end
