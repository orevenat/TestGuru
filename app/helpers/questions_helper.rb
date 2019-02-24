module QuestionsHelper
  def question_header(type, title)
    message = type == :create ? 'Create new' : 'Edit'
    "#{message} #{title} Question"
  end
end
