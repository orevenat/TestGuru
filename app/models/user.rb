class User < ApplicationRecord
  has_secure_password
  has_many :my_tests, class_name: 'Test', foreign_key: :author_id
  has_many :test_passages
  has_many :tests, through: :test_passages

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def find_test(level)
    tests.where(level: level)
  end
end
