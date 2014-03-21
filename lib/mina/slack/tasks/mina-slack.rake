set_default :slack_hook_url, ''
set_default :slack_payload, {text: ''}

namespace :slack do
  task :finish do
    slack_payload[:text] = "Finished deploy!"
    RestClient.post slack_hook_url, payload: slack_payload.to_json
  end
end
