class AddNewTable < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.string :fake_id
      t.string :message_type
      t.string :password
    end
  end
end
