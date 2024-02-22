require './lib/enerbot_slack'
require './lib/modules/message_slack'

describe MessageSlack do
  describe '#send_message' do
    let(:text) { 'RTest' }
    let(:test_channel) { 'energon_hq' }
    let(:fake_channel) { 'fake channel' }
    let(:slack) { EnerbotSlack.new }

    context 'when post succeeds' do
      it { expect(slack.send_message(text, test_channel).ok).to be true }
      it { expect(slack.send_message(text, test_channel).message.text).to eql text }
    end

    context 'when post fails' do
      it { expect(slack.send_message(text, fake_channel)).to be false }
    end
  end

  describe '#send_direct_message' do
    let(:test_id) { 'UR0KGQUQK' }
    let(:fake_id) { 'FAKEID123' }
    let(:test_channel) { 'energon_hq' }
    let(:slack) { EnerbotSlack.new }

    context 'when dm succeeds' do
      it { expect(slack.send_direct_message(test_id, test_channel)).equal?(Hash) }
    end

    context 'when dm fails' do
      it { expect(slack.send_direct_message(fake_id, test_channel)).to eql false }
    end
  end

  describe '#add_reaction' do
    let(:text) { 'Emoji thread' }
    let(:icon) { 'helicopter' }
    let(:fake_icon) { 'j' }
    let(:test_channel) { '#energon_hq' }
    let(:fake_channel) { 'hq-developmnt-logs' }
    let(:slack) { EnerbotSlack.new }
    let(:message) { slack.send_message(text, test_channel).message }

    context 'when reaction succeeds' do
      it { expect(slack.add_reaction(icon, test_channel, message.ts)).to eql true }
    end

    context 'when reaction fails' do
      it { expect(slack.add_reaction(icon, fake_channel, message.ts)).to eql false }
      it { expect(slack.add_reaction(fake_icon, test_channel, message.ts)).to eql false }
    end
  end
end
