class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order 'created_at DESC' }
  has_many :review2s
  has_many :queue_items

  validates :title, presence: true
  validates :description, presence: true

  before_create :generate_token

  has_attached_file :image, styles: {
    large: "665x375#",
    thumb: "166x236#"
  }
  validates_attachment_content_type :image, :content_type => /\Aimage/

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

  def to_param
    token
  end

  private
  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
