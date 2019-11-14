#!/usr/bin/env ruby

require 'json'

require_relative 'lib/config'
require_relative 'lib/slack_notifier'

config_file = JSON.parse(File.read('config.json'))
config = Config.new(config_file)

slack = SlackNotifier.new(config.slack_webhook_url)
slack.send('Hello World!')