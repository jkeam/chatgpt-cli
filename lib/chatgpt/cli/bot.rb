# frozen_string_literal: true

require 'openai'
require_relative 'context'

module Chatgpt
  module Cli
    # Bot to communicate with ChatGPT
    class Bot
      def initialize(org_id, token, context: nil, uri_base: nil)
        OpenAI.configure do |config|
          config.access_token = token
          config.organization_id = org_id unless org_id.nil?
          config.uri_base = uri_base unless uri_base.nil?
        end
        @client = OpenAI::Client.new
        @context = context || Context.new
      end

      def ask(message, model: 'gpt-3.5-turbo')
        @context.add_user_message(message)
        @client.chat(parameters: { model:, messages: @context.context })
      rescue Faraday::TooManyRequestsError
        @context.add_bot_message('You exceeded your current quota, please check your plan and billing details.')
      rescue Faraday::UnauthorizedError
        @context.add_bot_message('Your token is unauthorized.')
      rescue Faraday::Error
        @context.add_bot_message('Unknown error occurred.')
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
        resp = response.dig('error', 'message')
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
