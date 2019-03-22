class BadgeCheckService
  def def initialize(user)
    @user = user
    @badges = Badge.all
  end

  def call(test_passage)
    if test_passage.completed?

    end
  end

  def private
end
