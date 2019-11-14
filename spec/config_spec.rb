# frozen_string_literal: true

require 'config'

RSpec.describe Config do
  context 'with a configuration file' do
    it 'reads the values from a file' do
      config_file = 'config.example.json'
      config = Config.from_file(config_file)
      expect(config.gitlab_url).to eq 'https://www.gitlab.com/'
      expect(config.gitlab_group_ids).to eq [3, 4, 5]
    end
  end
end
