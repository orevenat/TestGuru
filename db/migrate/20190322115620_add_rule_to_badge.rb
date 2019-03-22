class AddRuleToBadge < ActiveRecord::Migration[5.2]
  def change
    add_reference :badges, :rule, foreign_key: true
  end
end
