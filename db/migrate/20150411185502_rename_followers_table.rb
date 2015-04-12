class RenameFollowersTable < ActiveRecord::Migration
  def change
    rename_table :followers, :followings
  end
end
