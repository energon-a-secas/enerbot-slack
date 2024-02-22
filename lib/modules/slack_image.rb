# frozen_string_literal: true

require_relative 'slack_search'

# Obtains data of user from Slack and then uses them to mimic looks.
module SlackImage
  def imitate_look(user)
    c = get_user_info(user)
    name = c.profile.display_name
    image = c.profile.image_512
    event_look_set(name, image)
  end

  def event_look_set(name, image)
    ENV['SLACK_BOT_ICON'] = image
    ENV['SLACK_BOT_NAME'] = name
  end

  def event_look_revert
    ENV['SLACK_BOT_ICON'] = 'https://i.imgur.com/uo5AfyZ.png'
    ENV['SLACK_BOT_NAME'] = 'Chayannetor'
  end
end
