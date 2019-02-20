class Question < ApplicationRecord
  belongs_to :test
  has_many :answers

  validates :body, presence: true
  validate :validate_answers

  def validate_answers
    errors.add(:answers, 'must be between 1 and 4') if answers.size > 4 \
      && !answers.empty?
  end
end
