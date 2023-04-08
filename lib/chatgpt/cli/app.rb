# frozen_string_literal: true

require 'dotenv/load'
require 'tty-spinner'
require_relative 'bot'
require_relative 'io_util'
require_relative 'spinner'

module Chatgpt
  module Cli
    # Main app
    class App
      # rubocop:disable Lint/AssignmentInCondition
      # rubocop:disable Metrics/MethodLength
      # rubocop:disable Metrics/CyclomaticComplexity
      # rubocop:disable Metrics/AbcSize
      def self.main(bot = nil, input = nil)
        bot ||= Bot.new(ENV.fetch('OPENAI_ORGANIZATION_ID'), ENV.fetch('OPENAI_ACCESS_TOKEN'))
        spinner = Spinner.new
        IoUtil.print_welcome
        while message = IoUtil.read_input(input)
          break if IoUtil.contains_quit_command(message)

          case message
          when %r{^[/\\]image}
            spinner.start
            resp = bot.draw(IoUtil.get_user_prompt(message, %w[image]))
            spinner.success
            puts resp
          when %r{^[/\\]history}
            puts bot.history
          when %r{^[/\\]reset}
            bot.reset
            puts 'Context reset'
          when %r{^[/\\]help}, ''
            IoUtil.print_help
          else
            spinner.start
            resp = bot.ask(message)
            spinner.success
            puts resp
          end
        end
      end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/CyclomaticComplexity
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Lint/AssignmentInCondition
    end
  end
end
