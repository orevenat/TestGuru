class FeedbacksMailer < ApplicationMailer
  def feedback_send(feedback)
    @feedback = feedback

    mail to: Admin.first.email
  end
end
