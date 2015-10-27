class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :uid
      t.string :oauth_token
      t.string :email

      t.timestamps null: false
    end
  end
end
