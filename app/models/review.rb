class Review < ApplicationRecord
  belongs_to :user
  has_many :comments ,dependent: :destroy
  has_many :favorites ,dependent: :destroy

  validates :shop, presence: true, length: { in: 1..20 }
  validates :address, presence: true, length: { in: 10..50 }
  validates :genre, presence: true, length: { in: 2..10 }
  validates :title, presence: true, length: { in: 5..20 }
  validates :body, presence: true, length: { in: 2..400 }
  validates :star, presence: true

  geocoded_by :address#addressカラムの内容を緯度・経度に変換することを指定
  after_validation :geocode#バリデーションの実行後に変換処理を実行して、latitudeカラム・longitudeカラムに緯度・経度の値が入力

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}


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

