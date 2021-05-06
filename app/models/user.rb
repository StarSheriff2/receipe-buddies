class User < ApplicationRecord
  VALID_USERNAME_REGEX = /\A[\w+\-_]+\z/i
  validates :username, presence: true, format: { with: VALID_USERNAME_REGEX }, length: { maximum: 20 }
  validates :fullname, presence: true, length: { maximum: 40 }

  has_many :opinions, foreign_key: :author_id, dependent: :destroy

  has_many :followings, foreign_key: :follower_id
  has_many :followed_users, through: :followings, source: :followed

  has_many :inverse_followings, class_name: 'Following', foreign_key: :followed_id
  has_many :followers, through: :inverse_followings

  has_one_attached :avatar, dependent: :destroy

  scope :ordered_by_most_recent, -> { order(created_at: :desc).first(3) }

  #scope :new_suggestions, ->(users) { where.not('id = ?', [*users, self]).ordered_by_most_recent }

  def new_suggestions
    User.where.not(id: [*followed_users, self])
  end

  def opinions_from_followed_users
    Opinion.where(author_id: [*followed_users])
  end
end

# def friends_and_own_posts
#   Post.where(user_id: [*friends, self])
# end
