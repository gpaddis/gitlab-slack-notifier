# frozen_string_literal: true

require 'merge_request'
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

RSpec.describe SlackNotifier, '.format_merge_request' do
  yesterday = Date.today.prev_day.strftime('%Y-%m-%d\T%I:%M:%S\Z')

  context 'with an assigned, mergeable MR' do
    it 'formats the markdown string correctly' do
      merge_request = MergeRequest.new(
        title: 'Resolve "Fix checkout bug"',
        author: 'John Smith',
        web_url: 'https://www.gitlab.com/example/1',
        assignees: [{'name' => 'Jane Doe'}],
        updated_at: yesterday,
        merge_status: 'can_be_merged',
        work_in_progress: false
      )
      markdown = SlackNotifier.format_merge_request(merge_request)
      expect(markdown).to eq ":green_book: [Resolve \"Fix checkout bug\"](https://www.gitlab.com/example/1) - Updated by John Smith 1 day ago, assigned to Jane Doe\n"
    end
  end

  context 'with an assigned, not mergeable MR' do
    it 'formats the markdown string correctly' do
      merge_request = MergeRequest.new(
        title: 'Resolve "Fix checkout bug"',
        author: 'John Smith',
        web_url: 'https://www.gitlab.com/example/1',
        assignees: [{'name' => 'Jane Doe'}],
        updated_at: yesterday,
        merge_status: 'cannot_be_merged',
        work_in_progress: false
      )
      markdown = SlackNotifier.format_merge_request(merge_request)
      expect(markdown).to eq ":green_book: [Resolve \"Fix checkout bug\"](https://www.gitlab.com/example/1) - Updated by John Smith 1 day ago, assigned to Jane Doe :no_entry_sign: cannot be merged\n"
    end
  end
end