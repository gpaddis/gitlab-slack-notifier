# frozen_string_literal: true

require 'json'

# The configuration object containing the application settings.
class Config
  attr_reader :gitlab_url,
              :gitlab_token,
              :gitlab_group_ids,
              :slack_webhook_url

  def initialize(options = {})
    self.gitlab_url = options['gitlab_url']
    self.gitlab_token = options['gitlab_token']
    self.gitlab_group_ids = options['gitlab_group_ids']
    self.slack_webhook_url = options['slack_webhook_url']
  end

  def gitlab_url=(gitlab_url)
    validate('gitlab_url', gitlab_url)
    @gitlab_url = gitlab_url
  end

  def gitlab_token=(gitlab_token)
    validate('gitlab_token', gitlab_token)
    @gitlab_token = gitlab_token
  end

  def gitlab_group_ids=(gitlab_group_ids)
    validate('gitlab_group_ids', gitlab_group_ids)
    @gitlab_group_ids = gitlab_group_ids
  end

  def slack_webhook_url=(slack_webhook_url)
    validate('slack_webhook_url', slack_webhook_url)
    @slack_webhook_url = slack_webhook_url
  end

  # Raise a RuntimeError if the value is empty or nil.
  def validate(key, value)
    error = "Invalid value provided for #{key}. Check your configuration file."
    raise error if value.nil? || value.empty?
  end

  # Create a new Config instance from a JSON file.
  def self.from_file(filename)
    error = "Could not find #{filename} in the script directory."
    raise error unless File.file?(filename)

    new(JSON.parse(File.read(filename)))
  end
end
