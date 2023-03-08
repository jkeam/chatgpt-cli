# frozen_string_literal: true

require 'openai'

# Bot to communicate with ChatGPT
class Bot
  def initialize(org_id, token)
    @client = OpenAI::Client.new(access_token: token, organization_id: org_id)
  end

  def ask(message, model: 'gpt-3.5-turbo')
    response = @client.chat(
      parameters: {
        model: model,
        messages: [{ role: 'user', content: message }]
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end

  def draw(prompt, size: '256x256')
    response = @client.images.generate(parameters: {
      prompt: prompt,
      size: size
    })
    response.dig('data', 0, 'url')
  end
end
