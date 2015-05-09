class AddImageToVideo < ActiveRecord::Migration
  def change
  	add_attachment :videos, :image
  end
end
