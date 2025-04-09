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
        bot_resp = ''
        begin
          @context.add_user_message(message)
          @context.add_bot_message('')
          @client.chat(
            parameters: {
              model:,
              messages: @context.context,
              stream: proc do |chunk, _bytesize|
                msg = chunk.dig('choices', 0, 'delta', 'content')
                @context.append_bot_message(msg)
                print(msg)
              end
            }
          )
        rescue Faraday::TooManyRequestsError
          bot_resp = 'You exceeded your current quota, please check your plan and billing details.'
        rescue Faraday::UnauthorizedError
          bot_resp = 'Your token is unauthorized.'
        rescue Faraday::Error
          bot_resp = 'Unknown error occurred.'
        end
        "#{bot_resp}\n"
      end
      # rubocop:enable Metrics/MethodLength

      def reset(system_message = nil)
        @context.reset(system_message)
      end

      # Size can be
      #   dall-e-2: 256x256, 512x512 or 1024x1024
      #   dall-e-3: 1024x1024, 1024x1792 or 1792x1024
      # Model can be dall-e-2 or dall-e-3
      # Quality can be 'standard' or 'hd' for dall-e-3 only
      def draw(prompt, size: '1024x1024', model: 'dall-e-3', quality: 'standard')
        parameters = { prompt:, size:, model: }
        parameters[:quality] = quality if model == 'dall-e-3'
        bot_resp = ''
        begin
          response = @client.images.generate(parameters:)
          bot_resp = response.dig('data', 0, 'url')
        rescue Faraday::ResourceNotFound
          bot_resp = 'Error while trying to generate an image, are you sure your LLM service supports this?'
        end
        "#{bot_resp}\n"
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
