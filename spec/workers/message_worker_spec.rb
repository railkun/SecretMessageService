require 'spec_helper'

describe MessageWorker do

  let(:message) { Message.create(body:'Hello!', message_type: 'after_hour') }

  it 'enqueues another awesome job' do
    expect {
      MessageWorker.perform_at(1.hour.from_now, message.id)
    }.to change(MessageWorker.jobs, :size).by(1)
  end
end
