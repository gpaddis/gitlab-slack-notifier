# frozen_string_literal: true

require 'json'
require 'httparty'

require_relative 'merge_request'

# The Gitlab client retrieves the open merge requests
# for the groups specified in the configuration.
class Gitlab
  attr_reader :url, :token, :group_ids

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
    headers = { 'PRIVATE-TOKEN': token }
    merge_requests = []
    group_ids.each do |id|
      endpoint = "#{api_url}/groups/#{id}/merge_requests?state=opened"
      response = HTTParty.get(endpoint, headers: headers)
      merge_requests += JSON.parse(response.body)
    end
    merge_requests.map! { |mr| map_to_merge_request(mr) }
    merge_requests.reject!(&:wip?)
    merge_requests.sort! { |a, b| b.waiting_days <=> a.waiting_days }
  end

  # Map a merge request hash to a MergeRequest object.
  def map_to_merge_request(mr)
    MergeRequest.new(
      title: mr['title'],
      state: mr['state'],
      author: mr['author']['name'],
      web_url: mr['web_url'],
      assignees: mr['assignees'],
      updated_at: mr['updated_at'],
      description: mr['description'],
      merge_status: mr['merge_status'],
      work_in_progress: mr['work_in_progress']
    )
  end
end
