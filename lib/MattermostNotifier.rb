#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

class MattermostNotifier
  def initialize(webhook_url)
    @webhook_url = webhook_url
  end

  # https://docs.mattermost.com/developer/webhooks-incoming.html
  def send(message)
    headers = { 'Content-Type' => 'application/json' }
    payload = { text: message }.to_json
    HTTParty.post(@webhook_url, body: payload, headers: headers)
  end
end
