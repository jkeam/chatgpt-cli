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

      # rubocop:disable Metrics/MethodLength
      def ask(message, model: 'gpt-3.5-turbo')
        begin
          @context.add_user_message(message)
          response = @client.chat(parameters: { model:, messages: @context.context })
          bot_resp = response.dig('choices', 0, 'message', 'content')
        rescue Faraday::TooManyRequestsError
          bot_resp = 'You exceeded your current quota, please check your plan and billing details.'
        rescue Faraday::UnauthorizedError
          bot_resp = 'Your token is unauthorized.'
        rescue Faraday::Error
          bot_resp = 'Unknown error occurred.'
        end
        @context.add_bot_message(bot_resp)
        bot_resp
      end
      # rubocop:enable Metrics/MethodLength

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
