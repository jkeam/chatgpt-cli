# frozen_string_literal: true

require 'dotenv/load'
require './lib/bot'

def prompt
  print '> '
  $stdout.flush
end

bot = Bot.new(ENV.fetch('OPENAI_ORGANIZATION_ID'), ENV.fetch('OPENAI_ACCESS_TOKEN'))
puts 'Welcome to ChatGPT!  Start chatting!'
prompt
while message = gets.chomp
  break if %w[exit quit].include?(message)

  puts bot.ask(message)
  prompt
end
