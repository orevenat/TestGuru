class FeedbacksController < ApplicationController

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.valid?
      FeedbacksMailer.feedback_send(@feedback).deliver_now
      redirect_to result_feedbacks_path
    else
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:name, :email, :phone_number, :body)
  end
end
