class QuestionsController < ApplicationController

  before_action :find_test

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
  end

  def show
    @question = Question.find(params[:id])
  end

  def new; end

  def create
    render plain: question_params.inspect
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to test_questions_path
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def rescue_with_question_not_found
    render plain: 'Question not found'
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
