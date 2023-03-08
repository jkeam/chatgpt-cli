# frozen_string_literal: true

require 'dotenv/load'
require './lib/bot'
require './lib/io_util'

bot = Bot.new(ENV.fetch('OPENAI_ORGANIZATION_ID'), ENV.fetch('OPENAI_ACCESS_TOKEN'))
IoUtil.print_welcome
IoUtil.prompt
while message = gets.strip
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
