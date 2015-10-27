class AddFollowersAndFollowingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :followers, :string
    add_column :users, :following, :string
  end
end
