# frozen_string_literal: true

require 'gitlab'

RSpec.describe Gitlab do
  context 'with gitlab url and token' do
    it 'builds the correct api url when the base url is well-formed' do
      gitlab = Gitlab.new('https://gitlab.example.com/', 'abc123', %w[group1 group2])
      expect(gitlab.api_url).to eq 'https://gitlab.example.com/api/v4'
    end

    it 'removes redundant api uri from the url' do
      gitlab = Gitlab.new('https://gitlab.example.com/api/v4', 'abc123', %w[group1 group2])
      expect(gitlab.api_url).to eq 'https://gitlab.example.com/api/v4'
    end

    it 'adds removes trailing slashes from the url' do
      gitlab = Gitlab.new('https://gitlab.example.com', 'abc123', %w[group1 group2])
      expect(gitlab.api_url).to eq 'https://gitlab.example.com/api/v4'

      gitlab = Gitlab.new('https://gitlab.example.com/api/v4/', 'abc123', %w[group1 group2])
      expect(gitlab.api_url).to eq 'https://gitlab.example.com/api/v4'
    end
  end
end
