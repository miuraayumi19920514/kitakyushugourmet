class Review < ApplicationRecord
  belongs_to :user
  has_many :comments ,dependent: :destroy
  has_many :favorites ,dependent: :destroy
  
  validates :shop,  presence: true
  validates :address,  presence: true
  validates :title,  presence: true, length: { in: 5..30 }
  validates :body,  presence: true, length: { in: 2..400 }
  validates :star,  presence: true
end
