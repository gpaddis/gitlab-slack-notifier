# frozen_string_literal: true

require 'date'

# Docs: https://docs.gitlab.com/ee/api/merge_requests.html#list-group-merge-requests
class MergeRequest
  attr_reader :title,
              :author,
              :web_url,
              :description

  def initialize(options = {})
    @title = options[:title]
    @state = options[:state]
    @author = options[:author]
    @web_url = options[:web_url]
    @assignees = options[:assignees]
    @updated_at = options[:updated_at]
    @description = options[:description]
    @merge_status = options[:merge_status]
    @work_in_progress = options[:work_in_progress]
  end

  # Return a comma separated list of the MR assignees.
  def assignees
    @assignees == [] ? nil : @assignees.map { |a| a['name'] }.join(', ')
  end

  # Check if the merge request can be merged.
  def can_be_merged
    @merge_status == 'can_be_merged' && @work_in_progress == false
  end

  # The number of days the merge request is waiting to be merged.
  def waiting_days
    updated_at = Date.parse(@updated_at)
    (Date.today - updated_at).to_i
  end
end
