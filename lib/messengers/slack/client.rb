# frozen_string_literal: true

module Messengers
  module Slack
    class Client
      def self.post(message, channel)
        new.client.chat_postMessage(channel: channel, text: message, as_user: true)
      end

      def client
        ::Slack::Web::Client.new
      end
    end
  end
end
