# frozen_string_literal: true

require 'httparty'

# The Gitlab client retrieves the open merge requests
# for the groups specified in the configuration.
class Gitlab
  attr_reader :url, :group_ids

  def initialize(url, token, group_ids)
    @url = url
    @token = token
    @group_ids = group_ids
  end

  # Generate a well-formed api url.
  def api_url
    base_url = url.include?('/api/v4') ? url.sub('/api/v4', '') : url
    base_url.chomp('/') + '/api/v4'
  end

  # Get all open merge requests.
  def open_merge_requests
    headers = { 'PRIVATE-TOKEN': @token }
    group_ids.each do |id|
      endpoint = "#{api_url}/groups/#{id}/merge_requests?state=opened"
      response = HTTParty.get(endpoint, headers: headers)
      p response.body
    end
  end
end
