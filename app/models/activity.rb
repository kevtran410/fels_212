class Activity < ApplicationRecord
  belongs_to :user

  enum type: {follow: 0, unfollow: 1, finished_lesson: 2}

  validates :target_id, presence: true
  validates :user_id, presence: true
end
