class BadgeCheckService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @rules = Rule.all
  end

  def call
    @rules.each do |rule|
      @user.badges << rule.badge if send "#{rule.rule_type}_award?", rule
    end
  end

  private

  def category_award?(rule)
    Test.where(category_id: Category.find_by(title: rule.value).id).all? do |t|
      t.test_passages.where(user_id: @user.id).any?(&:success?)
    end
  end

  def level_award?(rule)
    Test.where(level: rule.value.to_i).all? do |t|
      t.test_passages.where(user_id: @user.id).any?(&:success?)
    end
  end

  def attempt_award?(rule)
    TestPassage.where(user_id: @user.id, test_id: @test_passage.test.id).count == rule.value.to_i
  end
end
