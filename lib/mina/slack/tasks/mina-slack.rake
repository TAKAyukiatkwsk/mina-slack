require 'rest_client'
require 'json'

set_default :slack_hook_url, ''
set_default :slack_payload_text, "Finished deploy"
set_default :slack_env, ->{ rails_env }

namespace :slack do
  task :finish do
    if slack_hook_url.empty?
      error "Please `set :slack_hook_url`."
      exit
    end

    if slack_payload_text.empty?
      error "Please `set :slack_payload_text`."
      exit
    end

    slack_payload = {text: "#{slack_payload_text} #{slack_env}"}
    RestClient.post slack_hook_url, payload: slack_payload.to_json
  end
end
