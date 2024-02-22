class Credentials
  def set_defaults
    @bot_token = ENV['SLACK_TOKEN']
    @bot_name = ENV['SLACK_NAME']
    @bot_icon = ENV['SLACK_ICON']
    @bot_channel = ENV['SLACK_DEFAULT_CHANNEL']
    @bot_default_output = ENV['SLACK_DEFAULT_OUTPUT']
  end
end
