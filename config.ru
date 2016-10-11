# require 'config/database.yml'
# run Sinatra::Application
require 'rubygems'
require 'bundler'
$stdout.sync = true
Bundler.require

require './app'

run Rack::URLMap.new('/' => App, '/sidekiq' => Sidekiq::Web)
