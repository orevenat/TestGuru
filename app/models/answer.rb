class Answer < ApplicationRecord
  belongs_to :question

  scope :correct, -> { where(correct: true) }

  validates :body, presence: true
  validate :validate_answers

  def validate_answers
    errors.add(:answers, 'Must be between 1 & 4') if question && question.answers.size >= 4
  end
end
