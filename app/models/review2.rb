class Review2 < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates_presence_of :content, :rating
end
