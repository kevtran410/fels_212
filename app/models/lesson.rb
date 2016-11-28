class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :results, inverse_of: :lesson, dependent: :destroy
  has_many :words, through: :results

  accepts_nested_attributes_for :results

  enum status: {init: 0, finished: 1, in_progress: 2}

  before_create :init_resutlts

  def get_score_text
    if score.present?
      "#{score}/#{category.word_count}"
    else
      "-"
    end
  end

  def assign_score
    score = 0
    results.each do |result|
      if result.answer.present? && result.answer.is_correct?
        score += 1
      end
    end
    assign_attributes score: score
  end

  def init_resutlts
    self.words = category.words.order("RANDOM()").limit(category.word_count)
  end

  def start_lesson
    assign_attributes end_time: Time.now + category.duration.minutes
    in_progress!
  end
end
