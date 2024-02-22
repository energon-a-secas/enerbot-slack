Gem::Specification.new do |s|
  s.name        = 'enerbot-slack'
  s.version     = '1.1.0'
  s.date        = '2024-02-13'
  s.summary     = 'Core functions for any kind of interaction with Slack'
  s.description = 'The dream of enerbot'
  s.authors     = ['Luciano Adonis']
  s.email       = 'luciano.adonisv@gmail.com'
  s.files       = ['lib/enerbot-slack.rb', 'lib/modules/credentials.rb', 'lib/modules/slack_admin.rb',
                   'lib/modules/slack_message.rb', 'lib/modules/slack_console.rb', 'lib/modules/slack_realtime.rb', 'lib/modules/slack_search.rb', 'lib/modules/slack_image.rb', 'lib/modules/slack_format.rb', 'lib/modules/slack_client.rb']
  s.homepage    =
    'https://rubygems.org/gems/core_slack'
  s.license = 'MIT'
  s.add_dependency 'async-websocket', '~> 0.8.0'
  s.add_dependency 'bson_ext'
  s.add_dependency 'colorize', '~> 0.8.1'
  s.add_dependency 'slack-ruby-client', '2.0.0'
  s.add_development_dependency 'rspec', '~> 3.2'
end
