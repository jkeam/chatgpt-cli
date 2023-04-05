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
        input.readline('> ', true)
      end

      def self.matches_command?(input, command)
        input =~ %r{^[/\\]#{command}}
      end

      def self.print_help
        puts 'Usage Help'
        puts 'Enter your chat message'
        puts ''
        puts 'Or one of the following slash commands:'
        puts '/image <image_prompt>'
        puts '/q to quit'
        true
      end
    end
  end
end
