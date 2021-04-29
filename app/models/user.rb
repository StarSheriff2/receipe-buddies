class User < ApplicationRecord
  validates :username, presence: true, length: { maximum: 20 }
  validates :fullname, presence: true, length: { maximum: 40 }

  has_many :opinions, foreign_key: :author_id, dependent: :destroy

  has_many :followings, foreign_key: :follower_id

  has_many :inverse_followings, class_name: 'Following', foreign_key: :followed_id
  has_many :followers, through: :inverse_followings
end
