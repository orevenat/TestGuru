class Feedback
  include ActiveModel::Model
  attr_accessor :name, :email, :phone_number, :body
  validates :name, :email, :phone_number, :body, presence: true
  validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
end
