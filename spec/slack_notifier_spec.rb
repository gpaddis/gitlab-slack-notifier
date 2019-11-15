# frozen_string_literal: true

require 'slack_notifier'

RSpec.describe SlackNotifier do
  context 'with a webhook url' do
    it 'creates a new notifier instance' do
      webhook_url = 'http://slack.example.com/1928fhd'
      notifier = SlackNotifier.new(webhook_url)
      expect(notifier.webhook_url).to eq webhook_url
    end
  end
end
