# frozen_string_literal: true

# Module for regular expressions that are common
module SlackFormat
  def attachment_style(text, pretext: 'Test', color: '#e93d94', author: '')
    attachment = []
    attachment << {
      "color": color,
      "author_name": author,
      "pretext": pretext,
      "text": text
    }
    attachment
  end

  def coin_pattern(text)
    check = text.match(/^<@(.*?)>.*(\+\+|--|balance)(.*)/ix)
    !check.nil? ? check.captures : false
  end

  def hyper_text_pattern(text, type = 'user')
    pattern = case type
              when 'user'
                /<@(.*)>/
              when 'channel'
                /<#(.*)\|(.*)>/
              when 'channel_fix'
                /\s#(.*?)\s/
              end
    text.match(pattern)
  end

  def channel_pattern(data)
    match = data.match(/\s(<[#@])?((.*)\|)?(.*?)(>)? (.*?)$/i)
    p match
    unless match.nil?
      channel = match.captures[2] || match.captures[3]
      text = match.captures[5]
      check_ts = channel.match(/(.*)-(\d*\.\d*)/)
      channel = check_ts.captures[0] unless check_ts.nil?
      thread = check_ts.captures[1] unless check_ts.nil?
    end
    [text, channel, thread]
  end
end
