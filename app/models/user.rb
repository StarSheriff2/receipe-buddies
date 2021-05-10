class User < ApplicationRecord
  VALID_USERNAME_REGEX = /\A[\w+\-_]+\z/i
  validates :username, presence: true, format: { with: VALID_USERNAME_REGEX }, length: { maximum: 20 }
  validates :fullname, presence: true, length: { maximum: 40 }

  has_many :opinions, foreign_key: :author_id, dependent: :destroy

  has_many :followings, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :followings, source: :followed

  has_many :inverse_followings, class_name: 'Following', foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :inverse_followings

  has_many :votes, dependent: :destroy

  has_one_attached :avatar, dependent: :destroy

  has_one_attached :cover_image, dependent: :destroy

  scope :ordered_by_most_recent, -> { order(created_at: :desc).first(3) }

  def new_suggestions
    User.where.not(id: [*followed_users, self])
  end

  def opinions_from_followed_users
    Opinion.where(author_id: [*followed_users])
  end

  def following?(user)
    followings.exists?(followed_id: user)
  end

  def following_record(user)
    Following.find_by(follower_id: self, followed_id: user)
  end

  def voted?(opinion)
    votes.exists?(opinion_id: opinion)
  end

  def vote_record(opinion)
    Vote.find_by(user_id: self, opinion_id: opinion)
  end
end
