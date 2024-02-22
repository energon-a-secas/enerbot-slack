# frozen_string_literal: true

require_relative 'slack_client'
require_relative 'slack_search'

# Communication and interactions methods with Slack
module SlackMessage
  include SlackClient
  include SlackSearch

  def destination_points(data, ts = nil)
    @thread = if data.respond_to? :thread_ts
                data.ts
              else
                ts unless ts.nil?
              end
    @channel = if data.respond_to? :channel
                 data.channel
               else
                 data
               end
  end

  def send_message(text, data, ts = nil)
    client = configure_client
    destination_points(data, ts)
    client.chat_postMessage channel: @channel,
                            text: text,
                            icon_url: ENV['SLACK_ICON'],
                            username: ENV['SLACK_NAME'],
                            thread_ts: @thread,
                            as_user: false
  rescue Slack::Web::Api::Errors::SlackError => e
    print e.message
    false
  end

  def send_direct_message(text, channel)
    dm = get_user_id(channel)
    dm == false ? false : send_message(text, dm)
  end

  def send_attachment(attachment, data, ts = nil)
    client = configure_client
    destination_points(data, ts)
    client.chat_postMessage channel: @channel,
                            attachments: attachment,
                            icon_url: ENV['SLACK_ICON'],
                            username: ENV['SLACK_NAME'],
                            thread_ts: @thread,
                            as_user: false
  rescue Slack::Web::Api::Errors::SlackError => e
    print e.message
    false
  end

  def send_ephemeral(text, user, data, ts = nil)
    client = configure_client
    destination_points(data, ts)
    client.chat_postEphemeral channel: @channel,
                              text: text,
                              user: user,
                              icon_url: ENV['SLACK_ICON'],
                              username: ENV['SLACK_NAME'],
                              as_user: false
  rescue Slack::Web::Api::Errors::SlackError => e
    print e.message
    false
  end

  def send_command(command, text, data, ts = nil)
    client = configure_client('web', ENV['SLACK_REAL_TOKEN'])
    destination_points(data, ts)
    client.chat_command channel: @channel,
                        command: command,
                        text: text
  end

  def add_reaction(icon, channel, thread)
    client = configure_client
    client.reactions_add channel: channel,
                         name: icon,
                         timestamp: thread,
                         icon_url: ENV['SLACK_ICON'],
                         username: ENV['SLACK_NAME'],
                         as_user: false
  rescue Slack::Web::Api::Errors::SlackError => e
    print e.message
    false
  end

  def send_file(path, data, ts = nil)
    file = path
    client = configure_client
    destination_points(data, ts)
    client.files_upload channels: @channel,
                        icon_url: ENV['SLACK_ICON'],
                        username: ENV['SLACK_NAME'],
                        thread_ts: @thread,
                        file: Faraday::UploadIO.new(file, 'text'),
                        title: File.basename(file),
                        filename: File.basename(file),
                        as_user: false
  rescue Slack::Web::Api::Errors::SlackError => e
    print e.message
    false
  end
end
