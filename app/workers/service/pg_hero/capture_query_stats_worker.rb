# frozen_string_literal: true

module Service
  module PgHero
    class CaptureQueryStatsWorker < Base
      def perform
        super

        invoke!('pghero:capture_query_stats')
      end
    end
  end
end
