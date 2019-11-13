# frozen_string_literal: true

# Docs: https://docs.gitlab.com/ee/api/merge_requests.html#list-group-merge-requests
# GET /groups/:id/merge_requests?state=opened
class MergeRequest
  attr_reader :title,
              :author,
              :web_url,
              :assignees,
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

  def can_be_merged
    @merge_status == 'can_be_merged'
  end
end
