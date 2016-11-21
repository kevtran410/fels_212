class Result < ApplicationRecord
  belongs_to :lesson, inverse_of: :results
  belongs_to :word
  belongs_to :answer, optional: true
end
