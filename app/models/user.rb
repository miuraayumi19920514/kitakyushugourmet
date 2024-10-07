class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  enum local_person: { local: 1, traveler: 0 }
  
  has_many :reviews ,dependent: :destroy
  has_many :comments ,dependent: :destroy
  has_many :favorites ,dependent: :destroy
  
  validates :email, presence: true
  validates :encrypted_password, presence: true, length: { minimum: 6 }, on: :create
  validates :name,  presence: true, length: { in: 2..20 }, uniqueness: true
  validates :local_person, presence: true
  
  has_one_attached :image
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
end
