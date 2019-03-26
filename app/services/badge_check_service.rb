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
    user_tests_ids = TestPassage.where(user_id: @user.id).select { |tp| tp.success? && tp.test.category.title == rule.value }.map(&:test).map(&:id).uniq.sort
    real_tests_ids =Test.where(category_id: Category.find_by(title: rule.value).id).ids.uniq.sort
    user_tests_ids == real_tests_ids
  end

  def level_award?(rule)
    Test.where(level: rule.value.to_i).ids.uniq.sort == TestPassage.where(user_id: @user.id).select { |tp| tp.test.level == rule.value.to_i && tp.success? }.map(&:test).map(&:id).uniq.sort
  end

  def attempt_award?(rule)
    TestPassage.where(user_id: @user.id, test_id: @test_passage.test.id).count == rule.value.to_i
  end
end
