ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'database_cleaner'
require "./app"
require 'capybara'
require 'capybara/dsl'
require 'test/unit'
require 'rack/test'
require 'sidekiq/testing'

Sidekiq::Testing.fake!

RSpec.configure do |config|

  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:each) do
    Sidekiq::Worker.clear_all
  end
end
