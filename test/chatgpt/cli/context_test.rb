# frozen_string_literal: true

require 'minitest/autorun'
require 'vcr'
require_relative '../../../lib/chatgpt/cli/context'

module Chatgpt
  module Cli
    describe 'context' do
      it 'can reset' do
        context = Context.new

        assert_empty(context.context)
      end

      it 'can reset with system message' do
        context = Context.new
        context.reset('you are a bot')

        assert_equal([{ role: 'system', content: 'you are a bot' }], context.context)
      end

      it 'can create with system message' do
        context = Context.new('you are a bot')

        assert_equal([{ role: 'system', content: 'you are a bot' }], context.context)
      end

      it 'can add user message' do
        context = Context.new

        assert_empty(context.context)

        context.add_user_message('hi!')

        assert_equal([{ role: 'user', content: 'hi!' }], context.context)
      end

      it 'can add bot message' do
        context = Context.new

        assert_empty(context.context)

        context.add_bot_message('hi!')

        assert_equal([{ role: 'assistant', content: 'hi!' }], context.context)
      end
    end
  end
end
