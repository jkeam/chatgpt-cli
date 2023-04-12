# frozen_string_literal: true

require 'tty-spinner'

module Chatgpt
  module Cli
    # Spinner class
    class Spinner
      def initialize(spinner = nil)
        @spinner = spinner || TTY::Spinner.new(':spinner',
                                               format: :dots, clear: true, success_mark: '-->', error_mark: 'x')
      end

      def start
        @spinner.reset
        @spinner.auto_spin
      end

      def success
        @spinner.success
      end

      def error
        @spinner.error
      end

      def execute(&func)
        start
        resp = func.call
        success
        resp
      end
    end
  end
end
