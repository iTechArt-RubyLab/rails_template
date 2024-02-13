# frozen_string_literal: true

module Service
  class Base
    include Sidekiq::Worker

    def perform
      RailsTemplate::Application.load_tasks
    end

    private

    def invoke!(task)
      Rake::Task[task].invoke
    end
  end
end
