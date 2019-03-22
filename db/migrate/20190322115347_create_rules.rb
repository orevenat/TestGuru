class CreateRules < ActiveRecord::Migration[5.2]
  def change
    create_table :rules do |t|
      t.string :type
      t.string :value

      t.timestamps
    end
  end
end
