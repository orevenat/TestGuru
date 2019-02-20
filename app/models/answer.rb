class Answer < ApplicationRecord
  belongs_to :question

  scope :correct, -> { where(correct: true) }

  validates :body, presence: true
  validate :validate_answers

  def validate_answers
    errors.add(:answers, 'must be between 1 and 4') if question.answers.size > 4
  end
end
