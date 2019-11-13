#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

# Notify a Mattermost instance using a webhook url.
class MattermostNotifier
  attr_accessor :webhook_url

  def initialize(webhook_url)
    self.webhook_url = webhook_url
  end

  # Docs: https://docs.mattermost.com/developer/webhooks-incoming.html
  def send(message)
    headers = { 'Content-Type' => 'application/json' }
    payload = { text: message }.to_json
    HTTParty.post(@webhook_url, body: payload, headers: headers)
  end
end
