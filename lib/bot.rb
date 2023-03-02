# frozen_string_literal: true

require 'openai'

# Bot to communicate with ChatGPT
class Bot
  def initialize(org_id, token)
    OpenAI.configure do |config|
      config.access_token = token
      config.organization_id = org_id
    end
    @client = OpenAI::Client.new
  end

  def ask(message)
    response = @client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [{ role: 'user', content: message }]
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end
end
