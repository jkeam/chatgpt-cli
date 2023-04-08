# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../../lib/chatgpt/cli/app'

module Chatgpt
  module Cli
    describe 'app' do
      it 'can run' do
        input = Minitest::Mock.new
        input.expect(:readline, '\quit', ['> ', true])

        bot = Minitest::Mock.new

        App.main(bot, input)
        input.verify
        bot.verify
      end
    end
  end
end
