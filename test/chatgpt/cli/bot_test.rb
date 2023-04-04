# frozen_string_literal: true

require 'minitest/autorun'
require 'vcr'
require_relative '../../../lib/chatgpt/cli/bot'

module Chatgpt
  module Cli
    describe 'bot' do
      it 'can ask' do
        VCR.use_cassette('ask') do
          bot = Bot.new 'org-test', 'sk-token'
          response = bot.ask 'hi'

          refute_nil response
        end
      end

      it 'can draw' do
        VCR.use_cassette('draw') do
          bot = Bot.new 'org-test', 'sk-token'
          response = bot.draw 'cat'

          refute_nil response
        end
      end
    end
  end
end
