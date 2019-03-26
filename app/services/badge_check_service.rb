class BadgeCheckService
  def initialize(user, test_passage)
    @user = user
    @test_passage = test_passage
    @rules = Rule.all
  end

  def call
    @rules.each do |rule|
      @user.badges << rule.badge if send "#{rule.rule_type}_award?", rule
    end
  end

  private

  def category_award?(rule)
    TestPassage.where(user_id: @user.id).select {|tp| tp.test.category.title == rule.value && tp.success? }.count == Test.where(category_id: Category.find_by(title: rule.value).id).count
  end

  def level_award?(rule)
    Test.where(level: rule.value.to_i).count == TestPassage.where(user_id: @user.id).select { |tp| tp.test.level == rule.value.to_i && tp.success? }.count
  end

  def attempt_award?(rule)
    TestPassage.where(user_id: @user.id, test_id: @test_passage.test.id).count == rule.value.to_i
  end
end
