class BadgeCheckService
  def initialize(user)
    @user = user
    @badges = Badge.all
    @checks = []
  end

  def call(test_passage)

  end
end
