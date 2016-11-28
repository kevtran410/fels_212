class Word < ApplicationRecord
  belongs_to :category

  has_many :answers, inverse_of: :word, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :lessons, through: :results

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: lambda {|attributes| attributes[:content].blank?}

  validates :content, presence: true
  validate :valid_number_answers
  validate :valid_corect_answers

  scope :search_words, ->(search_value, category_id){joins(:answers).
    where("words.content LIKE ? AND category_id = ? AND is_correct = ?",
    "%#{search_value}%", category_id, true).
    select "words.content, answers.content as a_content, words.created_at"}

  scope :find_all, ->(user_id, category_id){joins(:answers).
    where("category_id = ? AND is_correct = ?", category_id, true).
    select "words.content, answers.content as a_content, words.created_at"}

  scope :alphabet,->{order content: :asc}
  scope :newest, ->{order created_at: :desc}
  scope :oldest, ->{order created_at: :asc}

  scope :learned_words, ->(user_id, category_id){
    where "words.id in (SELECT r.word_id FROM results r join lessons l
    on r.lesson_id = l.id WHERE l.user_id = ? AND l.category_id = ?)",
      user_id, category_id}

  scope :not_learned_words, ->(user_id, category_id){
    where "words.id not in (SELECT r.word_id FROM results r join lessons l
    on r.lesson_id = l.id WHERE l.user_id = ? AND l.category_id = ?) AND
    words.category_id = ?", user_id, category_id, category_id}

  class << self
    def search search_value, category_id
      words = if search_value
        search_words search_value, category_id
      end
    end
  end

  private
  def valid_number_answers
    min = Settings.mininum_answers_count
    if answers.size < min
      errors.add :answer,
        I18n.t("admin.answer_count_error_message", min_valid_answers: min)
    end
  end

  def valid_corect_answers
    count = 0
    answers.each do |answer|
      count = count + 1 if answer.is_correct?
    end
    unless count == 1
      errors.add :answers,
        I18n.t("admin.correct_answer_count_error_message")
    end
  end
end
