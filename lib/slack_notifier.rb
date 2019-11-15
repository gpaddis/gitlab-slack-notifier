#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'httparty'

# Notify a Slack instance using a webhook url.
class SlackNotifier
  attr_accessor :webhook_url

  def initialize(webhook_url)
    self.webhook_url = webhook_url
  end

  # Docs: https://api.slack.com/messaging/webhooks#posting_with_webhooks
  # Docs: https://docs.mattermost.com/developer/webhooks-incoming.html
  def send(message)
    headers = { 'Content-Type' => 'application/json' }
    payload = { text: message }.to_json
    HTTParty.post(@webhook_url, body: payload, headers: headers)
  end

  # Format a merge request as a Markdown one-liner.
  def self.format_merge_request(mr)
    importance = if mr.waiting_days <= 1
                   ':green_book:'
                 elsif mr.waiting_days > 1 && mr.waiting_days < 7
                   ':orange_book:'
                 else
                   ':closed_book:'
                 end
    plural = mr.waiting_days == 1 ? 'day' : 'days'
    assignees = mr.assignees ? "assigned to #{mr.assignees}" : 'no assignees yet'
    "#{importance}[#{mr.title}](#{mr.web_url}) - Updated by #{mr.author} #{mr.waiting_days} #{plural} ago, #{assignees}\n"
  end
end
