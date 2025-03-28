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
        bot ||= Bot.new(ENV.fetch('OPENAI_ORGANIZATION_ID', nil), ENV.fetch('OPENAI_ACCESS_TOKEN'))
        model_name ||= ENV.fetch('MODEL_NAME', 'gpt-4o')
        spinner = Spinner.new
        IoUtil.print_welcome
        while message = IoUtil.read_input(input)
          break if IoUtil.contains_quit_command(message)

          case message
          when %r{^[/\\]image}
            puts(spinner.execute { bot.draw(IoUtil.get_user_prompt(message, %w[image])) })
          when %r{^[/\\]history}
            puts bot.history
          when %r{^[/\\]reset}
            bot.reset
            puts 'Context reset'
          when %r{^[/\\]help}, ''
            IoUtil.print_help
          else
            puts(spinner.execute { bot.ask(message, model: model_name) })
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
