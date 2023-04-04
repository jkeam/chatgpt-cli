# frozen_string_literal: true

require 'dotenv/load'
require_relative 'lib/bot'
require_relative 'lib/io_util'

def main(bot=nil)
  bot ||= Bot.new(ENV.fetch('OPENAI_ORGANIZATION_ID'), ENV.fetch('OPENAI_ACCESS_TOKEN'))
  IoUtil.print_welcome
  IoUtil.prompt
  while message = IoUtil.read_input
    break if IoUtil.contains_quit_command(message)

    if IoUtil.matches_command?(message, %w[image])
      puts bot.draw(IoUtil.get_user_prompt(message, %w[image]))
    elsif IoUtil.matches_command?(message, %w[help h]) || message == ''
      IoUtil.print_help
    else
      puts bot.ask(message)
    end

    IoUtil.prompt
  end
end
main
