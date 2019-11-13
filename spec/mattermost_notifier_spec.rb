# frozen_string_literal: true

require 'mattermost_notifier'

RSpec.describe MattermostNotifier do
  context 'with a webhook url' do
    it 'creates a new notifier instance' do
      webhook_url = 'http://www.example.com/1928fhd'
      notifier = MattermostNotifier.new(webhook_url)
      expect(notifier.webhook_url).to eq webhook_url
    end
  end
end
