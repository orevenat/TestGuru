class User < ApplicationRecord
  has_secure_password

  def find_test(level)
    query = 'JOIN user_tests ON test_id = tests.id'
    Test.where(level: level).joins(query).where(user_tests: { user_id: id })
  end
end
