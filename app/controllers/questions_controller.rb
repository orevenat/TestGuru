class QuestionsController < ApplicationController
  def index
    @test = Test.find(params[:test_id])
    @questions = @test.questions
  end

  def show
    @test = Test.find(params[:test_id])
    @question = Question.find(params[:id])
  end

  def new
    @test = Test.find(params[:test_id])
  end

  def create
    render plain: question_params.inspect
  end

  def destroy
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end
end
