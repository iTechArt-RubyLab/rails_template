# frozen_string_literal: true

module Service
  module PgHero
    class CaptureSpaceStatsWorker < Base
      def perform
        super

        invoke!('pghero:capture_space_stats')
      end
    end
  end
end
