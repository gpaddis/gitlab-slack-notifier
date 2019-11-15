#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'httparty'

# Notify a Slack / Mattermost instance using a webhook url.
class SlackNotifier
  attr_accessor :webhook_url

  def initialize(webhook_url)
    self.webhook_url = webhook_url
  end

  # Send a message using the Slack / Mattermost webhook.
  # Docs: https://api.slack.com/messaging/webhooks#posting_with_webhooks
  # Docs: https://docs.mattermost.com/developer/webhooks-incoming.html
  def send(message)
    headers = { 'Content-Type' => 'application/json' }
    payload = { text: message }.to_json
    HTTParty.post(@webhook_url, body: payload, headers: headers)
  end
end
