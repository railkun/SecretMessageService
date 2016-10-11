# require 'config/database.yml'
# run Sinatra::Application
require 'rubygems'
require 'bundler'

Bundler.require

require './app'

run Rack::URLMap.new('/' => App, '/sidekiq' => Sidekiq::Web)
