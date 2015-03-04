class CreateReview2s < ActiveRecord::Migration
  def change
    create_table :review2s do |t|
      t.text :content
      t.integer :rating
      t.integer :user_id
      t.integer :video_id

      t.timestamps
    end
  end
end
