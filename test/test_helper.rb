# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'chatgpt/cli'
require 'minitest/autorun'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'test/chatgpt/cli/vcr_cassettes'
  config.hook_into :webmock
end
