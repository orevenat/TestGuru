module QuestionsHelper
  def question_header(question)
    message = question.new_record? ? 'Create new' : 'Edit'
    "#{message} #{question.test.title} Question"
  end
end
