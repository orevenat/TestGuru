class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :my_tests, class_name: 'Test', foreign_key: :author_id
  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :user_badges
  has_many :badges, through: :user_badges
  has_many :gists

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    is_a?(Admin)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def find_test(level)
    tests.where(level: level)
  end
end
