# frozen_string_literal: true

require 'json'

# The configuration object containing the application settings.
class Config
  attr_reader :gitlab_url,
              :gitlab_token,
              :gitlab_groups,
              :slack_webhook_url

  def initialize(options = {})
    @gitlab_url = options['gitlab_url']
    @gitlab_token = options['gitlab_token']
    @gitlab_groups = options['gitlab_groups']
    @slack_webhook_url = options['slack_webhook_url']
  end

  # Create a new Config instance from a JSON file.
  def self.from_file(filename)
    new(JSON.parse(File.read(filename)))
  end
end
