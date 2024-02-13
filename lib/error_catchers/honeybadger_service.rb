# frozen_string_literal: true

module ErrorCatchers
  class HoneybadgerService
    def self.notify(exception)
      Honeybadger.notify(exception)
    end
  end
end
