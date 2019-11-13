# frozen_string_literal: true

require 'merge_request'

RSpec.describe MergeRequest do
  context 'an open merge request' do
    it 'can be merged' do
      mr = MergeRequest.new(merge_status: 'can_be_merged')
      expect(mr.can_be_merged).to be true
    end

    it 'cannot be merged' do
      mr = MergeRequest.new(merge_status: 'cannot_be_merged')
      expect(mr.can_be_merged).to be false
    end
  end
end
