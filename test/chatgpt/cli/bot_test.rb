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

        bot = Bot.new 'org-test', 'sk-token', context: mock
        bot.reset
        mock.verify
      end

      it 'can get history' do
        mock = Minitest::Mock.new
        mock.expect(:context, [])

        bot = Bot.new 'org-test', 'sk-token', context: mock
        bot.history
        mock.verify
      end

      it 'can handle too many request errors' do
        VCR.use_cassette('too-many-request-error') do
          bot = Bot.new 'org-test', 'sk-token'
          response = bot.ask 'hi'

          refute_nil response
          assert_equal(
            "You exceeded your current quota, please check your plan and billing details.\n",
            response
          )
        end
      end

      it 'can handle unauthorized errors' do
        VCR.use_cassette('unauthorized-error') do
          bot = Bot.new 'org-test', 'sk-token'
          response = bot.ask 'hi'

          refute_nil response
          assert_equal(
            "Your token is unauthorized.\n",
            response
          )
        end
      end

      it 'can handle unknown errors' do
        VCR.use_cassette('unknown-error') do
          bot = Bot.new 'org-test', 'sk-token'
          response = bot.ask 'hi'

          refute_nil response
          assert_equal(
            "Unknown error occurred.\n",
            response
          )
        end
      end
      # rubocop:enable Metrics/BlockLength
    end
  end
end
