# frozen_string_literal: true

module Chatgpt
  module Cli
    # Context - keeping track of user context
    class Context
      attr_reader :context

      def initialize(system_message = nil)
        @context = []
        return if system_message.nil?

        @context.push({ role: 'system', content: system_message })
      end

      def reset(system_message = nil)
        @context.clear
        return if system_message.nil?

        @context.push({ role: 'system', content: system_message })
        self
      end

      def add_user_message(message)
        @context.push({ role: 'user', content: message })
        self
      end

      def add_bot_message(message)
        @context.push({ role: 'assistant', content: message })
        self
      end

      def append_bot_message(message)
        # thread unsafe code, following needs to be atomic
        @context[-1][:content] = "#{@context[-1][:content]}#{message}"
        self
      end
    end
  end
end
