# frozen_string_literal: true

require 'json'
require 'net/http'
require 'mina'

# Slack tasks
namespace :slack do
  # Required
  set :slack_token,       -> { ENV['SLACK_TOKEN'] }
  set :slack_room,        -> { ENV['SLACK_ROOM'] }
  set :slack_subdomain,   -> { ENV['SLACK_SUBDOMAIN'] }
  # Optional
  set :slack_stage,       -> { ENV['SLACK_STAGE'] || fetch(:rails_env, 'production') }
  set :slack_application, -> { ENV['SLACK_APPLICATION'] || fetch(:application_name) }
  set :slack_username,    -> { ENV['SLACK_USERNAME'] || 'deploybot' }
  set :slack_emoji,       -> { ENV['SLACK_EMOJI'] || ':cloud:' }
  # Git
  set :deployer,          -> { ENV['GIT_AUTHOR_NAME'] || `git config user.name`.chomp }
  set :deployed_revision, -> { ENV['GIT_COMMIT'] || `git rev-parse #{fetch(:branch)} | cut -c 1-7`.strip }

  task :starting do
    if fetch(:slack_token) && fetch(:slack_room) && fetch(:slack_subdomain)
      announcement = "#{fetch(:deployer)} is deploying #{announced_application_name} to #{fetch(:slack_stage)}"

      post_slack_message(announcement)
      set(:start_time, Time.now)
    else
      print_error 'Unable to create Slack Announcement, no slack details provided.'
    end
  end

  task :finished do
    if fetch(:slack_token) && fetch(:slack_room) && fetch(:slack_subdomain)
      end_time = Time.now
      start_time = fetch(:start_time)
      elapsed = end_time.to_i - start_time.to_i

      announcement = "#{fetch(:deployer)} successfully deployed #{announced_application_name} in #{elapsed} seconds."

      post_slack_message(announcement)
    else
      print_error 'Unable to create Slack Announcement, no slack details provided.'
    end
  end

  def announced_application_name
    (+'').tap do |output|
      output << fetch(:slack_application)
      output << " #{fetch(:branch)}" if fetch(:branch)
      output << " (#{fetch(:deployed_revision)})" if fetch(:deployed_revision)
    end
  end

  def post_slack_message(message)
    return if fetch(:simulate)
    # Parse the URI and handle the https connection
    uri = URI.parse("https://#{fetch(:slack_subdomain)}.slack.com/services/hooks/incoming-webhook?token=#{fetch(:slack_token)}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    payload = {
      'parse'       => 'full',
      'channel'     => fetch(:slack_room),
      'username'    => fetch(:slack_username),
      'text'        => message,
      'icon_emoji'  => fetch(:slack_emoji)
    }

    # Create the post request and setup the form data
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(payload: payload.to_json)

    # Make the actual request to the API
    http.request(request)
  end
end
