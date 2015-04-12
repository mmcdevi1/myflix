class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews, -> { order 'created_at' }
  has_many :queue_items, -> { order 'position' }
  has_many :relationships, foreign_key: :follower_id
  has_many :followings, through: :relationships
  has_many :followers, through: :relationships

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  def normalize_queue_items_position
    queue_items.each_with_index do |queue_items, index|
      queue_items.update_attributes(position: index+1)
    end
  end

  def follows?(another_user)
    relationships.map(&:following).include?(another_user)
  end

  def can_follow?(another_user)
    !(self.follows?(another_user) || self == another_user)
  end
end
