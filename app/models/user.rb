class User < ApplicationRecord
  VALID_USERNAME_REGEX = /\A[\w+\-_]+\z/i
  validates :username, presence: true, format: { with: VALID_USERNAME_REGEX }, length: { maximum: 20 }
  validates :fullname, presence: true, length: { maximum: 40 }

  has_many :opinions, foreign_key: :author_id, dependent: :destroy

  has_many :followings, foreign_key: :follower_id

  has_many :inverse_followings, class_name: 'Following', foreign_key: :followed_id
  has_many :followers, through: :inverse_followings

  has_one_attached :avatar, dependent: :destroy

  scope :ordered_by_most_recent, ->(user) { where.not('id = ?', user).order(created_at: :desc).first(3) }
end
