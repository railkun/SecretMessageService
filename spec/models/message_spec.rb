require "spec_helper"

describe "message" do
  it "create_new_message" do
    message = Message.create(body:'Hello!', message_type: 'first_visit')
    expect(message.fake_id).not_to be_nil
    expect(message).to be_valid

  end

  it 'validation fails' do
    message = Message.create
    expect(message.errors.count).to eq(2)
  end
end
