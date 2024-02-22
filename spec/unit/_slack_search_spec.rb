# frozen_string_literal: true

require_relative '../spec_helper'
require './lib/slack_search'

describe SlackSearch do
  describe '#search_messages_on' do
    let(:test_channel) { ENV['SLACK_TEST_CHANNEL'] }
    let(:fake_channel) { ENV['SLACK_FAKE_CHANNEL'] }
    let(:slack) { DummyClass.new.extend(SlackSearch) }

    context 'when retrieve succeeds' do
      it { expect(slack.search_messages_on(test_channel, 1).ok).to eq true }
    end

    context 'when retrieve fails' do
      it { expect(slack.search_messages_on(fake_channel, 1)).to eq "Channel not found #{fake_channel}" }
    end
  end

  describe '#get_user_info' do
    let(:test_id) { ENV['SLACK_TEST_USER'] }
    let(:fake_id) { ENV['SLACK_FAKE_USER'] }
    let(:slack) { DummyClass.new.extend(SlackSearch) }

    context 'when retrieve succeeds' do
      it { expect(slack.get_user_info(test_id).id).to eq test_id }
    end

    context 'when retrieve fails' do
      it { expect(slack.get_user_info(fake_id)).to eq false }
    end
  end
end
