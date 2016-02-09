class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :password_digest
      t.string :authentication_token
      t.timestamp :token_expires_at
      t.timestamps null: false
    end
  end
end
