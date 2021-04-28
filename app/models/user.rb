class User < ApplicationRecord
  validates :username, presence: true, length: { maximum: 20 }
  validates :fullname, presence: true, length: { maximum: 40 }

  has_many :opinions, foreign_key: :author_id, dependent: :destroy
end
