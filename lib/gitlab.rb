# frozen_string_literal: true

# The Gitlab client retrieves the open merge requests
# for the groups specified in the configuration.
class Gitlab
  def initialize(url, token, groups)
    @url = url
    @token = token
    @groups = groups
  end
end
