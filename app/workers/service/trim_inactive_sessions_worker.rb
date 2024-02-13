# frozen_string_literal: true

module Service
  class TrimInactiveSessionsWorker < Base
    def perform
      super

      invoke!('db:sessions:trim')
    end
  end
end
