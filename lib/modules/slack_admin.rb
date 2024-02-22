# frozen_string_literal: true

# Selection that should be improved
module SlackAdmin
  def root_list_include?(user)
    ENV['SLACK_BOT_ADMINS'].include? user
  rescue NoMethodError => e
    puts "You probably didn't set the SLACK_BOT_ADMINS variable. Error: #{e.message}"
    false
  end
end
