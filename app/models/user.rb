class User < ApplicationRecord
  has_secure_password
  has_many :my_tests, class_name: 'Test', foreign_key: :author_id
  has_many :tests_users
  has_many :tests, through: :tests_users

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def find_test(level)
    tests.where(level: level)
  end
end
