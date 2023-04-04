# frozen_string_literal: true

require 'minitest/autorun'

module Chatgpt
  module Cli
    describe 'app' do
      it 'can run' do
        require_relative '../../../lib/chatgpt/cli/app'
      end
    end
  end
end
