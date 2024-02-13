# frozen_string_literal: true

module Service
  class ClearLogAndTmpWorker < Base
    def perform
      super

      %w(log:clear tmp:clear).each { |task| invoke!(task) }
    end
  end
end
