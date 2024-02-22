# frozen_string_literal: true

module Api
  class Httpbin
    include HTTParty

    base_uri 'https://httpbin.org'
    headers(content_type: 'application/json')

    class << self
      def _anything
        request('/anything')
      end

      def _ip
        request('/ip')
      end

      def _user_agent
        request('/user_agent')
      end

      def _headers
        request('/headers')
      end

      def _status(code)
        request("/status/#{code}")
      end

      private

      def request(path)
        ActiveSupport::HashWithIndifferentAccess.new(get(path))
      end
    end
  end
end
