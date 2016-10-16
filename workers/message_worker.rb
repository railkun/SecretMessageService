class MessageWorker
  include Sidekiq::Worker
  def perform(message_id)
    m = Message.find(message_id)
    m.deleted_at = Time.now
    m.save
  end
end
