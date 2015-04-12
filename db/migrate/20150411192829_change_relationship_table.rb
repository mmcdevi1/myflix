class ChangeRelationshipTable < ActiveRecord::Migration
  def change
    rename_column :relationships, :follower_id, :following_id
    rename_column :relationships, :user_id, :follower_id
  end
end
