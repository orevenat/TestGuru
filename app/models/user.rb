class User < ApplicationRecord
  has_secure_password

  def find_test(level)
    query = "JOIN user_tests ON test_id = tests.id AND user_id = #{id}"
    Test.where(level: level).joins(query)
  end
end
