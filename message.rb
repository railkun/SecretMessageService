class Message < ActiveRecord::Base

  attr_encrypted :body, key: '#fy@iDpd5pNyDU1(RppK*BbWGpPZdx&&'

  default_scope { where(deleted_at: nil) }

  before_create :generate_fake_id


  def generate_fake_id
    new_id = SecureRandom.urlsafe_base64
    while Message.where(fake_id: new_id).any? do
      new_id = SecureRandom.urlsafe_base64
    end
    self.fake_id = new_id
  end
end
