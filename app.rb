require 'sinatra'
require 'sinatra/activerecord'
require 'attr_encrypted'
require './message'
require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq/web'

require_relative 'workers/message_worker.rb'

class App < Sinatra::Base



  post "/create" do
    message = Message.new(body: params[:body], message_type: params[:message_type])
    message.save
    if message.message_type == 'after_hour'
      MessageWorker.perform_in(1.minutes, message.id)
    end
    redirect to("/?fake_id=#{message.fake_id}")
  end

  get "/" do
   @message = Message.find_by(fake_id: params[:fake_id])
   erb :home

  end

  get '/message/:fake_id' do
    message = Message.find_by(fake_id: params[:fake_id])
    message.created_at = Time.now
    if message.message_type == 'first_visit'
      message.deleted_at = Time.now
    end
    message.save
    message.body
  end
end
