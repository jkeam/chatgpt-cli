# frozen_string_literal: true

require 'readline'

module Chatgpt
  module Cli
    # IO Utility
    class IoUtil
      def self.contains_quit_command(input)
        %w[exit quit /exit /quit /q \\q \\quit \\exit].include?(input)
      end

      def self.print_welcome
        puts 'Welcome to ChatGPT, start chatting!'
        true
      end

      def self.get_user_prompt(input, keyword)
        input.sub(%r{^/#{keyword}\s+}, '')
      end

      def self.read_input(input = Readline)
        input ||= Readline
        input.readline('> ', true)
      end

      def self.print_help
        puts '---------------------------------------------------'
        puts 'Usage Help: Enter your chat message'
        puts 'Or one of the following slash commands:'
        puts '  /h or /help for this help'
        puts '  /reset to reset this context'
        puts '  /image <image_prompt> but only works with OpenAI'
        puts '  /history'
        puts '  /q or quit to quit'
        puts '---------------------------------------------------'
        true
      end
    end
  end
end
