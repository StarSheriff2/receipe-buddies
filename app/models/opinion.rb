class Opinion < ApplicationRecord
  validates :text, presence: true, length: { maximum: 1000,
                                             too_long: '1000 characters in opinion is the maximum allowed.' }

  belongs_to :author, class_name: 'User'

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }

  scope :created_after_last_logout, ->(last_logout_date) { where('created_at > ? AND created_at > ?', last_logout_date, 1.day.ago) }
end
