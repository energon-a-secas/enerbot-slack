require_relative 'slack_message'
require_relative 'slack_console'
require './actions/modes'

# Module for reading chat incoming messages
module SlackRealTime
  include SlackConsole
  include DirectiveLookup

  def share_message(data, output)
    case output
    when 'slack'
      check_type(data)
    when 'console'
      format_new_message(data)
    else
      format_new_message(data)
      check_type(data)
    end
  end

  def single_client(output = ENV['SLACK_DEFAULT_OUTPUT'])
    @time_client.on :hello do
      puts("Connected to '#{@time_client.team.name}' team at https://#{@time_client.team.domain}.slack.com.")
    end

    @time_client.on :message do |data|
      share_message(data, output)
    end
    @time_client.start!
  end
end
