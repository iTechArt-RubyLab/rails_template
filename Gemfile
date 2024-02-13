source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

gem 'rails', '~> 7.1', '>= 7.1.3'


# DBMS

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5', '>= 1.5.4'
# A library for bulk inserting data using ActiveRecord
gem 'activerecord-import', '~> 1.5', '>= 1.5.1'
# An Action Dispatch session store backed by an Active Record class
gem 'activerecord-session_store', '~> 2.1'
# Parses SQL queries using a copy of the PostgreSQL server query parser
gem 'pg_query', '~> 5.1'
# A performance dashboard for Postgres
gem 'pghero', '~> 3.4', '>= 3.4.1'
# Adds methods to ActiveRecord::Migration to create and manage database views in Rails
gem 'scenic', '~> 1.7'
# A Ruby client that tries to match Redis' API one-to-one, while still providing an idiomatic interface
gem 'redis', '~> 5.1'


# Serialization

# Create JSON structures via a Builder-style DSL
gem 'jbuilder', '~> 2.11', '>= 2.11.5'


# Concurrency and processes

# Simple, fast, threaded, and highly parallel HTTP 1.1 server for Ruby/Rack applications
gem 'puma', '~> 6.4', '>= 6.4.2'
# Popen, but with stderr, too
gem 'open3', '~> 0.2.1'


# Background jobs

# Simple, efficient background processing for Ruby
gem 'sidekiq', '~> 7.2', '>= 7.2.1'
# Enables to set jobs to be run in specified time (using CRON notation or natural language)
gem 'sidekiq-cron', '~> 1.12'
# An extension to the sidekiq message processing to track your jobs
gem 'sidekiq-status', '~> 3.0', '>= 3.0.3'
# Prevents simultaneous Sidekiq jobs with the same unique arguments to run
gem 'sidekiq-unique-jobs', '~> 8.0', '>= 8.0.7'
# Concurrency and rate-limit throttling for Sidekiq
gem 'sidekiq-throttled', '~> 1.3'
# Keep track of Sidekiq failed jobs
gem 'sidekiq-failures', '~> 1.0', '>= 1.0.4'


# Exceptions, performance, metrics, notifications

# Managing application errors
gem 'honeybadger', '~> 5.4', '>= 5.4.1'
# Slack Web and RealTime API client
gem 'slack-ruby-client', '~> 2.3'
# Ruby wrapper for Telegram's Bot API
gem 'telegram-bot-ruby', '~> 2.0'


# External API interactions

# Makes consuming restful web services dead easy
gem 'httparty', '~> 0.21.0'
# Middleware that will make Rack-based apps CORS compatible
gem 'rack-cors', '~> 2.0', '>= 2.0.1'
# Access the contents of various spreadsheet files
gem 'roo', '~> 2.10', '>= 2.10.1'


# Parsers and formatters

# Makes it easy and painless to work with XML and HTML from Ruby
gem 'nokogiri', '~> 1.16', '>= 1.16.2'
# Fast, tiny, and nimble PDF generator for Ruby
gem 'prawn', '~> 2.4'


# Common

# Continuation of the acts-as-state-machine rails plugin, built for plain Ruby objects
gem 'aasm', '~> 5.5'
# Upload files in your Ruby applications, map them to a range of ORMs, store them on different backends
gem 'carrierwave', '~> 3.0', '>= 3.0.5'
# Clean, powerful, agnostic, customizable and sophisticated paginator
gem 'kaminari', '~> 1.2', '>= 1.2.2'
# Track changes to your models, for auditing or versioning
gem 'paper_trail', '~> 15.1'
# Re-implementation of acts_as_paranoid performing soft deleting on a record
gem 'paranoia', '~> 2.6', '>= 2.6.3'

# An implementation of Matrix and Vector classes
gem 'matrix', '~> 0.4.2'
# Sprockets Rails integration
gem 'sprockets-rails', '~> 3.4', '>= 3.4.2'
# Rails engine for Turbolinks 5 support
gem 'turbolinks', '~> 5.2', '>= 5.2.1'


group :development, :test do
  # Brakeman detects security vulnerabilities in Ruby on Rails applications via static analysis
  gem 'brakeman', '~> 6.1', '>= 6.1.2'

  # Provides patch-level verification for Bundled apps
  gem 'bundler-audit', '~> 0.9.1'

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri windows ]

  # Autoload dotenv in Rails
  gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'

  # To check various places in your code that could be faster
  gem 'fasterer', '~> 0.11.0'

  # Combine 'pry' with 'byebug'
  gem 'pry-byebug', '~> 3.10', '>= 3.10.1'

  # Pry REPL plugin that provides extended documentation support
  gem 'pry-doc', '~> 1.5'

  # Use Pry as your rails console
  gem 'pry-rails', '~> 0.3.9'

  # Walk the stack in a Pry session
  gem 'pry-stack_explorer', '~> 0.6.1'

  # A code metric tool for rails codes, written in Ruby
  gem 'rails_best_practices', '~> 1.23', '>= 1.23.2'

  # A tool that examines Ruby classes, modules and methods and reports any code smells it finds
  gem 'reek', '~> 6.3'
end

group :development do
  # Annotates Rails/ActiveRecord Models, routes, fixtures, and others based on the database schema
  gem 'annotate', '~> 3.2'

  # Pretty print Ruby objects to visualize their structure
  gem 'awesome_print', '~> 1.9', '>= 1.9.2'

  # Help to kill N+1 queries and unused eager loading
  gem 'bullet', '~> 7.1', '>= 7.1.6'

  # When mail is sent from your application, it will open a preview in the browser instead of sending
  gem 'letter_opener', '~> 1.8', '>= 1.8.1'

  # Automatically generate an entity-relationship diagram (ERD) for your Rails models
  gem 'rails-erd', '~> 1.7', '>= 1.7.2'

  # Ruby code style checking and code formatting tool
  gem 'rubocop', '~> 1.60', '>= 1.60.2', require: false

  # A collection of RuboCop cops to check for performance optimizations in Ruby code.
  gem 'rubocop-performance', '~> 1.20', '>= 1.20.2', require: false

  # Automatic Rails code style checking tool
  gem 'rubocop-rails', '~> 2.23', '>= 2.23.1', require: false

  # Code style checking for RSpec files
  gem 'rubocop-rspec', '~> 2.26', '>= 2.26.1', require: false

  # This Rake task investigates the application's routes definition, then tells you unused routes and unreachable action methods
  gem 'traceroute', '~> 0.8.1'
end
