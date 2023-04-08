# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../../lib/chatgpt/cli/spinner'

module Chatgpt
  module Cli
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
    end
  end
end
