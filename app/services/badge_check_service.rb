class BadgeCheckService
  def initialize(user, test_passage)
    @user = user
    @test_passage = test_passage
    @rules = Rule.all
  end

  def call
    @rules.each do |rule|
      @current_user.badges << rule.badges if send "#{rule.rule_type}_award?", rule
    end
  end

  private

  def category_award?(rule)
    TestPassages.where(user_id: @current_user.id).select {|tp| tp.test.category == rule.category && tp.success? } == Test.where(category_id: rule.value.to_i)
  end

  def level_award?(rule)
    Test.where(level: rule.value.to_i).count == TestPassage.where(user_id: @current_user.id).select { |tp| tp.test.level == 3 && tp.success? }.count
  end

  def attepmt_award?(_rule)
    @test_passage.find_by(user_id: @current_user.id).count == 1
  end
end
