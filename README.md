# Mina::Slack

[Slack](https://slack.com) web hook from [mina](https://github.com/nadarei/mina).

## Installation

Add this line to your application's Gemfile:

    gem 'mina-slack'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mina-slack
    
In your slack settings, create new Incomming WebHooks and get WebHooks URL.

## Usage

In `config/deploy.rb`

```ruby
require 'mina/slack/tasks'
    
# Set your WebHooks URL
set :slack_hook_url, 'https://my.slack.com/services/hooks/incoming-webhook?token=token'
# Set deployment env
# default is value of settings.rails_env
set :slack_env, 'production'
    
# Invoke slack task in your deploy task
task :deploy do
  deploy do
    # some deploy commands...
  end
  invoke :'slack:finish'
end
```

Notify text is `Finished deploy production` if you configure like above.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
