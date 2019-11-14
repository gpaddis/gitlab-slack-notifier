# frozen_string_literal: true

class Gitlab
  def initialize(url, token, groups)
    @url = url
    @token = token
    @groups = groups
  end
end
