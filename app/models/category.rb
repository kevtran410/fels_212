class Category < ApplicationRecord
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates :name, presence: true, length: {minimum: 3}
  validates :duration, presence: true, numericality: {only_integer: true}
  validates :word_count, presence: true, numericality: {only_integer: true}

  scope :ongoing_course, ->(user_id){joins(:lessons).
    where("lessons.user_id = ?", user_id).group("categories.id")}
  scope :search_categories, ->(search_value){where "name LIKE ?",
    "%#{search_value}%"}
  
  class << self
    def search search_value
      categories = if search_value
        search_categories search_value
      else
        Category.all
      end
    end
  end
end
