# frozen_string_literal: true

require_relative '../spec_helper'
require './lib/slack_admin'

describe SlackAdmin do
  describe '#root_list_include' do
    let(:admin_user) { ENV['SLACK_TEST_USER'] }
    let(:normal_user) { ENV['SLACK_FAKE_USER'] }
    let(:admin_list) { ENV['SLACK_BOT_ADMINS'] }
    let(:slack) { DummyClass.new.extend(SlackAdmin) }

    context 'when check succeeds' do
      it { expect(slack.root_list_include?(admin_user)).to eq true }
    end

    context 'when check fails' do
      it { expect(slack.root_list_include?(normal_user)).to eq false }
    end
  end
end
