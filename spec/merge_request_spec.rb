# frozen_string_literal: true

require 'date'
require 'merge_request'

RSpec.describe MergeRequest, '#can_be_merged?' do
  context 'an open merge request' do
    it 'can be merged' do
      mr = MergeRequest.new(merge_status: 'can_be_merged', work_in_progress: false)
      expect(mr.can_be_merged?).to be true
    end

    it 'cannot be merged if the status is set to cannot_be_merged' do
      mr = MergeRequest.new(merge_status: 'cannot_be_merged')
      expect(mr.can_be_merged?).to be false
    end
  end
end

RSpec.describe MergeRequest, '#wip?' do
  context 'an open merge request' do
    it 'is marked as work in progress' do
      mr = MergeRequest.new(work_in_progress: true)
      expect(mr.wip?).to be true
    end

    it 'is not marked as work in progress' do
      mr = MergeRequest.new(work_in_progress: false)
      expect(mr.wip?).to be false
    end
  end
end

RSpec.describe MergeRequest, '#updated_string' do
  datetime_pattern = '%Y-%m-%d\T%I:%M:%S\Z'

  context 'a merge request wast last updated' do
    it 'was updated today' do
      today = Date.today.strftime(datetime_pattern)
      mr = MergeRequest.new(updated_at: today)
      expect(mr.updated_string).to eq 'today'
    end

    it 'was updated yesterday' do
      yesterday = Date.today.prev_day.strftime(datetime_pattern)
      mr = MergeRequest.new(updated_at: yesterday)
      expect(mr.updated_string).to eq 'yesterday'
    end

    it 'was updated 2 days ago' do
      two_days_ago = Date.today.prev_day.prev_day.strftime(datetime_pattern)
      mr = MergeRequest.new(updated_at: two_days_ago)
      expect(mr.updated_string).to eq '2 days ago'
    end
  end
end

RSpec.describe MergeRequest, '#assignees' do
  it 'returns the names of the assignees' do
    assignees = [
      {
        'id' => 123,
        'name' => 'John Smith',
        'username' => 'john.smith',
        'state' => 'active',
        'avatar_url' => 'https://www.gitlab.com/uploads/-/system/user/avatar/123/avatar.png',
        'web_url' => 'https://www.gitlab.com/john.smith'
      }
    ]

    mr = MergeRequest.new(assignees: assignees)
    expect(mr.assignees).to eq 'John Smith'
  end

  it 'returns nil if the merge request has no assignees' do
    mr = MergeRequest.new(assignees: [])
    expect(mr.assignees).to be nil
  end
end

RSpec.describe MergeRequest, '#to_markdown' do
  yesterday = Date.today.prev_day.strftime('%Y-%m-%d\T%I:%M:%S\Z')

  context 'with an assigned, mergeable MR' do
    it 'formats the markdown string correctly' do
      merge_request = MergeRequest.new(
        title: 'Resolve "Fix checkout bug"',
        author: 'John Smith',
        web_url: 'https://www.gitlab.com/example/1',
        assignees: [{ 'name' => 'Jane Doe' }],
        updated_at: yesterday,
        merge_status: 'can_be_merged',
        work_in_progress: false
      )
      formatted = ':green_book: [Resolve "Fix checkout bug"]' \
                  '(https://www.gitlab.com/example/1) - ' \
                  "Author: John Smith, updated yesterday, assigned to Jane Doe\n"
      expect(merge_request.to_markdown).to eq formatted
    end
  end

  context 'with an assigned, not mergeable MR' do
    it 'formats the markdown string correctly' do
      merge_request = MergeRequest.new(
        title: 'Resolve "Fix checkout bug"',
        author: 'John Smith',
        web_url: 'https://www.gitlab.com/example/1',
        assignees: [{ 'name' => 'Jane Doe' }],
        updated_at: yesterday,
        merge_status: 'cannot_be_merged',
        work_in_progress: false
      )
      formatted = ':green_book: [Resolve "Fix checkout bug"]' \
                  '(https://www.gitlab.com/example/1) - ' \
                  'Author: John Smith, updated yesterday, assigned to Jane Doe ' \
                  ":no_entry_sign: cannot be merged\n"
      expect(merge_request.to_markdown).to eq formatted
    end
  end

  context 'with a not assigned, not mergeable MR' do
    it 'formats the markdown string correctly' do
      merge_request = MergeRequest.new(
        title: 'Resolve "Fix checkout bug"',
        author: 'John Smith',
        web_url: 'https://www.gitlab.com/example/1',
        assignees: [],
        updated_at: yesterday,
        merge_status: 'cannot_be_merged',
        work_in_progress: false
      )
      formatted = ':green_book: [Resolve "Fix checkout bug"]' \
                  '(https://www.gitlab.com/example/1) - ' \
                  'Author: John Smith, updated yesterday ' \
                  ":no_entry_sign: cannot be merged\n"
      expect(merge_request.to_markdown).to eq formatted
    end
  end
end
