class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  enum local_person: { local: 1, traveler: 0 }
  
  has_many :reviews ,dependent: :destroy
  has_many :comments ,dependent: :destroy
  has_many :favorites ,dependent: :destroy
  
end
