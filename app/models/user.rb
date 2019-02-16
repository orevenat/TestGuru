class User < ApplicationRecord
  has_secure_password

  def find_test(level)
    tests = UserTest.where(user_id: id).pluck(:test_id)
    Test.where(id: tests).where(level: level)
  end
end
