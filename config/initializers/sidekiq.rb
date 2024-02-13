# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'
require 'sidekiq-status'
require 'sidekiq-status/web'
require 'sidekiq/throttled'

Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV['REDIS_URL']
  }

  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes.to_i
    chain.add SidekiqUniqueJobs::Middleware::Client
  end

  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes.to_i
    chain.add SidekiqUniqueJobs::Middleware::Server
  end

  SidekiqUniqueJobs::Server.configure(config)

  config.on(:startup) do
    Sidekiq::Cron::Job.load_from_hash!(
      Dir.glob(Rails.root.join('config/cron_schedules/*.yml')).each_with_object({}) do |schedule_file, tasks|
        tasks.merge!(YAML.load_file(schedule_file))
      end
    )
  end

  config.error_handlers << ->(exception, _context_hash, _) {
    ErrorCatchers::HoneybadgerService.notify(exception)
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV['REDIS_URL']
  }

  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes.to_i
    chain.add SidekiqUniqueJobs::Middleware::Client
  end
end
