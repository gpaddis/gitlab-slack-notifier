# frozen_string_literal: true

require 'date'
require 'merge_request'

RSpec.describe MergeRequest do
  context 'an open merge request' do
    it 'can be merged' do
      mr = MergeRequest.new(merge_status: 'can_be_merged', work_in_progress: false)
      expect(mr.can_be_merged).to be true
    end

    it 'cannot be merged if the status is set to cannot_be_merged' do
      mr = MergeRequest.new(merge_status: 'cannot_be_merged')
      expect(mr.can_be_merged).to be false
    end

    it 'cannot be merged if work in progress' do
      mr = MergeRequest.new(work_in_progress: true, merge_status: 'can_be_merged')
      expect(mr.can_be_merged).to be false
    end
  end
end

RSpec.describe MergeRequest, '#waiting_days' do
  datetime_pattern = '%Y-%m-%d\T%I:%M:%S\Z'

  context 'a merge request wast last updated' do
    it 'was last updated today' do
      today = Date.today.strftime(datetime_pattern)
      mr = MergeRequest.new(updated_at: today)
      expect(mr.waiting_days).to eq 0
    end

    it 'has been waiting since yesterday' do
      yesterday = Date.today.prev_day.strftime(datetime_pattern)
      mr = MergeRequest.new(updated_at: yesterday)
      expect(mr.waiting_days).to eq 1
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

  it 'returns nil if the mr has no assignees' do
    mr = MergeRequest.new(assignees: [])
    expect(mr.assignees).to be nil
  end
end
