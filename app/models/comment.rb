class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :votes
  validates :comment_info, presence: true
end
