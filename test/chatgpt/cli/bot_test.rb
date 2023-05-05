# frozen_string_literal: true

require 'minitest/autorun'
require 'vcr'
require_relative '../../../lib/chatgpt/cli/bot'

module Chatgpt
  module Cli
    # rubocop:disable Metrics/BlockLength
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

      it 'can reset context' do
        mock = Minitest::Mock.new
        mock.expect(:reset, nil, [nil])

        bot = Bot.new 'org-test', 'sk-token', mock
        bot.reset
        mock.verify
      end

      it 'can get history' do
        mock = Minitest::Mock.new
        mock.expect(:context, [])

        bot = Bot.new 'org-test', 'sk-token', mock
        bot.history
        mock.verify
      end

      it 'can handle errors' do
        VCR.use_cassette('known-error') do
          bot = Bot.new 'org-test', 'sk-token'
          response = bot.ask 'hi'

          refute_nil response
          assert_equal('You exceeded your current quota, please check your plan and billing details.', response)
        end
      end

      it 'can handle unknown errors' do
        VCR.use_cassette('unknown-error') do
          bot = Bot.new 'org-test', 'sk-token'
          response = bot.ask 'hi'

          refute_nil response
          assert_equal('An unknown error occurred.', response)
        end
      end
      # rubocop:enable Metrics/BlockLength
    end
  end
end
