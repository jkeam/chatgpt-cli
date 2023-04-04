# frozen_string_literal: true

module Chatgpt
  module Cli
    # IO Utility
    class IoUtil
      def self.prompt
        print '> '
        $stdout.flush
        true
      end

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

      def self.read_input(input = $stdin)
        input.gets&.strip
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
