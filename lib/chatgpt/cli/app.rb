# frozen_string_literal: true

require 'dotenv/load'
require_relative 'bot'
require_relative 'io_util'

module Chatgpt
  module Cli
    # Main app
    class App
      # rubocop:disable Lint/AssignmentInCondition
      # rubocop:disable Metrics/MethodLength
      # rubocop:disable Metrics/AbcSize
      def self.main(bot = nil)
        bot ||= Bot.new(ENV.fetch('OPENAI_ORGANIZATION_ID'), ENV.fetch('OPENAI_ACCESS_TOKEN'))
        IoUtil.print_welcome
        IoUtil.prompt
        while message = IoUtil.read_input
          break if IoUtil.contains_quit_command(message)

          if IoUtil.matches_command?(message, %w[image])
            puts bot.draw(IoUtil.get_user_prompt(message, %w[image]))
          elsif IoUtil.matches_command?(message, %w[help h]) || message == ''
            IoUtil.print_help
          else
            puts bot.ask(message)
          end

          IoUtil.prompt
        end
      end
      # rubocop:enable Lint/AssignmentInCondition
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Metrics/AbcSize
    end
  end
end
