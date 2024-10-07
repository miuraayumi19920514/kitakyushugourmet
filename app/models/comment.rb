class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  
  validates :comment,  presence: true, length: { in: 2..50 }
end
