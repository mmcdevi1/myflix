class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews, -> { order 'created_at' }
  has_many :queue_items, -> { order 'position' }

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  def normalize_queue_items_position
    queue_items.each_with_index do |queue_items, index|
      queue_items.update_attributes(position: index+1)
    end
  end
end
