require "mina/slack/version"
require 'rest-client'
require 'json'

module Mina
  module Slack
  end
end

load File.expand_path("../slack/tasks/mina-slack.rake", __FILE__)
