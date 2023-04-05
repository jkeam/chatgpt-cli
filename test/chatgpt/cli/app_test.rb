# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../../lib/chatgpt/cli/app'

module Chatgpt
  module Cli
    describe 'app' do
      it 'can run' do
        mock = Minitest::Mock.new
        mock.expect(:readline, '\quit', ['> ', true])
        App.main(nil, mock)
        mock.verify
      end
    end
  end
end
