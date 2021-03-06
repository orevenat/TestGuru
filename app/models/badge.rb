class Badge < ApplicationRecord
  belongs_to :rule
  has_many :user_badges
  has_many :users, through: :user_badges

  validates :name, :picture, presence: true
end
