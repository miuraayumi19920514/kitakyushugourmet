class Review < ApplicationRecord
  belongs_to :user
  has_many :comments ,dependent: :destroy
  has_many :favorites ,dependent: :destroy

  validates :shop,  presence: true
  validates :address,  presence: true
  validates :title,  presence: true, length: { in: 5..30 }
  validates :body,  presence: true, length: { in: 2..400 }
  validates :star,  presence: true

  has_one_attached :image
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited?(user)
    return false unless user
    favorites.where(user_id: user.id).exists?
  end

end

