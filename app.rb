require 'sinatra'
require 'sinatra/activerecord'
require 'attr_encrypted'
require './message'
require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq/web'

require_relative 'workers/message_worker.rb'

class App < Sinatra::Base

  get "/" do
    erb :home
  end

  post "/create" do
    message = Message.new(body: params[:body], message_type: params[:message_type])
    message.save
    if message.message_type == 'after_hour'
      MessageWorker.perform_in(1.minutes, message.id)
    end
    message.fake_id
  end

  get '/message/:fake_id' do
    message = Message.find_by(fake_id: params[:fake_id])
    if message.message_type == 'first_visit'
      message.deleted_at = Time.now
    end
    message.save
    message.body
  end
end
