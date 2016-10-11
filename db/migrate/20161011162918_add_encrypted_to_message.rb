class AddEncryptedToMessage < ActiveRecord::Migration
  def change
    rename_column :messages, :body, :encrypted_body
    add_column :messages, :encrypted_body_iv, :string
  end
end
