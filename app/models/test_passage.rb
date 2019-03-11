class TestPassage < ApplicationRecord
  SUCCESS_RATE = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_update :before_update_set_next_question

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def result
    (correct_questions / test.questions.count * 100).round
  end

  def success?
    result >= SUCCESS_RATE
  end

  def current_number
    test.questions.where('id <= ?', current_question).count
  end

  def current_percent
    ((current_number.to_f - 1) / test.questions.count * 100).round
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def before_update_set_next_question
    self.current_question = test.questions
                                .order(:id)
                                .where('id > ?', current_question.id)
                                .first
  end

  def correct_answer?(answer_ids)
    return false if answer_ids.nil? || answer_ids.empty?

    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end
end
