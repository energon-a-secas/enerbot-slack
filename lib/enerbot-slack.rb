require 'slack-ruby-client'
require_relative 'modules/slack_realtime'
require_relative 'modules/slack_message'
require_relative 'modules/slack_search'
require_relative 'modules/slack_image'
require_relative 'modules/slack_format'
require_relative 'modules/credentials'

# Groups client initialization with instance parameters
class EnerbotSlack < Credentials
  include SlackRealTime
  include SlackMessage
  include SlackImage
  include SlackFormat
  include SlackSearch

  def initialize(name: '', image: '', token: nil, as_user: false)
    set_defaults

    Slack.configure do |config|
      config.token = token.nil? ? @bot_token : token
      config.raise 'Missing token' unless config.token
    end

    @bot_name = name unless name.empty?
    @bot_icon = image unless image.empty?
    @bot_user = as_user

    @time_client ||= Slack::RealTime::Client.new
    @web_client ||= Slack::Web::Client.new
  end
end
