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
    base_url = url
    base_url = url.chomp('api/v4') if url.include?('api/v4')
    base_url = url.chomp('api/v4/') if url.include?('api/v4/')
    base_url = base_url.chomp('/')
    base_url + '/api/v4'
  end
end
