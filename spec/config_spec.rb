# frozen_string_literal: true

require 'config'

RSpec.describe Config, '#from_file' do
  context 'with a valid configuration file' do
    it 'reads the values from a file' do
      config_file = 'config.example.json'
      config = Config.from_file(config_file)
      expect(config.gitlab_url).to eq 'https://www.gitlab.com/'
      expect(config.gitlab_group_ids).to eq [3, 4, 5]
    end
  end

  context 'without a valid configuration file' do
    it 'raises an exception if the file does not exist' do
      expect { Config.from_file('non-existing-file') }.to raise_error RuntimeError
    end

    it 'raises an exception if any of the options are empty' do
      options = {
        'gitlab_url' => 'https://www.gitlab.com/',
        'gitlab_token' => '',
        'gitlab_group_ids' => [1, 2, 3],
        'slack_webhook_url' => ''
      }
      error_message = 'Invalid value provided for gitlab_token. Check your configuration file.'
      expect { Config.new(options) }.to raise_error(error_message)
    end
  end
end
