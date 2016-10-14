ENV['RACK_ENV'] = 'test'

require "spec_helper"
require './app'  # <-- your sinatra app
require 'rspec'
require 'rack/test'


describe ".message" do
  include Rack::Test::Methods

  def app
    App::Application
  end

  it "fake_id not nil" do
    message = Message.create
    expect(message.fake_id).to be_nil
  end
end
