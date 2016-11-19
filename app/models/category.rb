class Category < ApplicationRecord
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates :name, presence: true, length: {minimum: 3}
  validates :duration, presence: true, numericality: {only_integer: true}
  validates :word_count, presence: true, numericality: {only_integer: true}

  scope :ongoing_course, ->(user_id){joins(:lessons).
    where("lessons.user_id = ?", user_id)}
end
