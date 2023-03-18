# frozen_string_literal: true

require 'minitest/autorun'
require 'vcr'
require_relative '../lib/bot'

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :webmock
end

describe 'bot' do
  it 'can ask' do
    VCR.use_cassette('ask') do
      bot = Bot.new 'org-test', 'sk-token'
      response = bot.ask 'hi'
      refute response.nil?
    end
  end

  it 'can draw' do
    VCR.use_cassette('draw') do
      bot = Bot.new 'org-test', 'sk-token'
      response = bot.draw 'cat'
      refute response.nil?
    end
  end
end
