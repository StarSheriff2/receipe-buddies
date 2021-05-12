class Session < ApplicationRecord
  validates :username, presence: true, length: { maximum: 20 }
end
