# frozen_string_literal: true

module Service
  module PgHero
    class CleanQueryStatsWorker < Base
      def perform
        super

        invoke!('pghero:clean_query_stats')
      end
    end
  end
end
