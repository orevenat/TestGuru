class User < ApplicationRecord
  has_secure_password
  has_many :author, class_name: 'User'
  has_many :tests_users
  has_many :tests, through: :tests_users

  def find_test(level)
    Test.where(level: level)
        .joins(:tests_users)
        .where(tests_users: { user_id: id })
  end
end
