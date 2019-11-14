# frozen_string_literal: true

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

    # it 'has been waiting since today' do
    #   # Check out: https://www.rubyguides.com/2015/12/ruby-time/
    #   updated_at = Time.now.strftime('%Y-%m-%d\T%I:%M:%S\Z')
    #   mr = MergeRequest.new(updated_at: updated_at)
    #   expect(mr.waiting_days).to eq 0
    # end
  end
end
