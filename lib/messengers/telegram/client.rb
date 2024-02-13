# frozen_string_literal: true

require 'telegram/bot'

module Messengers
  module Telegram
    class Client
      def self.post(text, chat_id)
        new.client.run(ENV['TELEGRAM_API_TOKEN']) { |bot| bot.api.send_message(chat_id: chat_id, text: text, parse_mode: 'html') }
      end

      def client
        ::Telegram::Bot::Client
      end
    end
  end
end
