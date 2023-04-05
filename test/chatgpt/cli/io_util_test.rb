# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'
require_relative '../../../lib/chatgpt/cli/io_util'

module Chatgpt
  module Cli
    # rubocop:disable Metrics/BlockLength
    describe 'io util' do
      it 'can print welcome' do
        assert IoUtil.print_welcome
      end

      it 'can print help' do
        assert IoUtil.print_help
      end

      it 'can find quit command' do
        assert IoUtil.contains_quit_command('\q')
        assert IoUtil.contains_quit_command('/q')
        assert IoUtil.contains_quit_command('quit')
        assert IoUtil.contains_quit_command('/quit')
        assert IoUtil.contains_quit_command('\quit')
        assert IoUtil.contains_quit_command('exit')
        assert IoUtil.contains_quit_command('/exit')
        assert IoUtil.contains_quit_command('\exit')
      end

      it 'can get user prompt' do
        assert_equal 'command', IoUtil.get_user_prompt('/test command', 'test')
        assert_equal 'command', IoUtil.get_user_prompt('/test    command', 'test')
      end

      it 'can read input' do
        mock = Minitest::Mock.new
        mock.expect(:readline, 'hi', ['> ', true])
        IoUtil.read_input(mock)
        mock.verify
      end

      it 'can print history' do
        mock = Minitest::Mock.new
        mock.expect(:to_a, ['hi'])
        IoUtil.print_history(mock)
        mock.verify
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
