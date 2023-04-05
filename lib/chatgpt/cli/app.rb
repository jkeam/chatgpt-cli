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
      def self.main(bot = nil, input = nil)
        bot ||= Bot.new(ENV.fetch('OPENAI_ORGANIZATION_ID'), ENV.fetch('OPENAI_ACCESS_TOKEN'))
        IoUtil.print_welcome
        while message = IoUtil.read_input(input)
          break if IoUtil.contains_quit_command(message)

          case message
          when %r{^[/\\]image}
            puts bot.draw(IoUtil.get_user_prompt(message, %w[image]))
          when %r{^[/\\]history}
            IoUtil.print_history
          when %r{^[/\\]help}, ''
            IoUtil.print_help
          else
            puts bot.ask(message)
          end
        end
      end
      # rubocop:enable Lint/AssignmentInCondition
      # rubocop:enable Metrics/MethodLength
    end
  end
end
