require './spec/spec_helper'
require './lib/enerbot_slack'
require './lib/modules/slack_console'

describe SlackConsole do
  describe '#channel_properties' do
    let(:text) { 'RTest' }
    let(:slack) { BaezSlack.new.extend(SlackConsole) }
    let(:type) {  DummyClass.new.struct }

    context 'when login succeeds' do
      it { expect(slack.format_new_message(type)).to eq('CQZA6RJ2E') }
    end
  end
end
