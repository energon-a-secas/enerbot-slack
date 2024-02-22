# frozen_string_literal: true

require 'slack-ruby-client'

# Client initialization that powers the rest of interactions
module SlackClient
  def configure_client(type = 'web', token = ENV['SLACK_TOKEN'])
    Slack.configure do |config|
      config.token = token
      config.raise 'Missing Bot token 2' unless config.token
    end

    case type
    when 'realtime'
      @configure_client = Slack::RealTime::Client.new
    when 'web'
      @configure_client = Slack::Web::Client.new
    end
  end
end
