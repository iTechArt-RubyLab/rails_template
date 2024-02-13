# frozen_string_literal: true

module Messengers
  module Slack
    class PostWorker
      include Sidekiq::Worker
      include Sidekiq::Throttled::Worker

      sidekiq_options queue: :messengers,
                      retry: false

      sidekiq_throttle(
        concurrency: { limit: 1 },
        threshold: { limit: 1, period: 2.seconds }
      )

      def perform(_opts)
        Client.post(
          'test',
          ENV['SLACK_CHANNEL']
        )
      end
    end
  end
end
