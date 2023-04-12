# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../../lib/chatgpt/cli/spinner'

module Chatgpt
  module Cli
    # rubocop:disable Metrics/BlockLength
    describe 'spinner' do
      it 'can start' do
        mock = Minitest::Mock.new
        mock.expect(:reset, true)
        mock.expect(:auto_spin, true)
        spinner = Spinner.new(mock)

        spinner.start
        mock.verify
      end

      it 'can be success' do
        mock = Minitest::Mock.new
        mock.expect(:success, true)
        spinner = Spinner.new(mock)

        assert spinner.success
        mock.verify
      end

      it 'can be error' do
        mock = Minitest::Mock.new
        mock.expect(:error, true)
        spinner = Spinner.new(mock)

        assert spinner.error
        mock.verify
      end

      it 'can execute block' do
        spinner_mock = Minitest::Mock.new
        spinner_mock.expect(:reset, true)
        spinner_mock.expect(:auto_spin, true)
        spinner_mock.expect(:success, true)
        spinner = Spinner.new(spinner_mock)

        func_mock = Minitest::Mock.new
        func_mock.expect(:go, true)

        assert(spinner.execute { func_mock.go })
        spinner_mock.verify
        func_mock.verify
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
