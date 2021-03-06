class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_test_passage, only: %i[show update result gist]
  before_action :check_test_ended, only: %i[show update]

  def show
  end

  def result
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      BadgeCheckService.new(@test_passage).call if @test_passage.success?
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    result = GistQuestionService.new(@test_passage.current_question).call

    redirect_to @test_passage, alert: t('.failure') unless result[:html_url]

    link = result[:html_url]

    Gist.create(
      user_id: current_user.id,
      question_id: @test_passage.current_question.id,
      url: link
    )

    redirect_to @test_passage, notice: t('.success', url: link)
  end

  private

  def check_test_ended
    timer = @test_passage.test.timer
    time_left = (@test_passage.created_at + timer) - Time.now
    redirect_to result_test_passage_path(@test_passage) if timer.positive? && time_left <= 0
  end

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
