require 'colorize'
require_relative 'slack_search'

# Module to read data from Slack and show it on console
module SlackConsole
  include SlackSearch

  def format_new_message(data)
    user_p = if data.subtype == 'bot_message'
               data.username
             else
               user = get_user_info(data.user)
               user.display_name
             end
    text = data.text
    channel_p = conversation_info(data.channel)
    if @current_channel == channel_p.id
    else
      print "\n--- #{channel_p.name} ---".green
    end
    print "\n#{user_p}: ".yellow + text.blue
    @current_channel = channel_p.id
  end
end
