# frozen_string_literal: true

require 'openai'
require_relative './context'

module Chatgpt
  module Cli
    # Bot to communicate with ChatGPT
    class Bot
      def initialize(org_id, token, context = nil)
        @client = OpenAI::Client.new(access_token: token, organization_id: org_id)
        @context = context || Context.new
      end

      def ask(message, model: 'gpt-3.5-turbo')
        @context.add_user_message(message)
        response = @client.chat(parameters: { model:, messages: @context.context })

        resp = response.dig('error', 'message')
        return resp unless resp.nil?

        handle_unknown_ask_error(response)
      end

      def reset(system_message = nil)
        @context.reset(system_message)
      end

      def draw(prompt, size: '256x256')
        response = @client.images.generate(parameters: { prompt:, size: })
        response.dig('data', 0, 'url')
      end

      def history
        @context.context
      end

      private

      def handle_unknown_ask_error(response)
        resp = response.dig('choices', 0, 'message', 'content')
        if resp.nil?
          resp = 'An unknown error occurred.'
          puts response
        else
          @context.add_bot_message(resp)
        end
        resp
      end
    end
  end
end
