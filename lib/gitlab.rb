# frozen_string_literal: true

# The Gitlab client retrieves the open merge requests
# for the groups specified in the configuration.
class Gitlab
  attr_reader :url

  def initialize(url, token, groups)
    @url = url
    @token = token
    @groups = groups
  end

  # Generate a well-formed api url.
  def api_url
    base_url = url.include?('/api/v4') ? url.sub('/api/v4', '') : url
    base_url.chomp('/') + '/api/v4'
  end

  # Get all open merge requests for the given group id.
  # GET /groups/:id/merge_requests?state=opened
  def get_open_merge_requests(group_id)
    headers = { 'PRIVATE-TOKEN': @token }
  end
end
