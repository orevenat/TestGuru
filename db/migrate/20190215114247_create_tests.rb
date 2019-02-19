class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :title, null: false
      t.integer :level, null: false, default: 0
      t.references :category, foreign_key: true
      t.integer :author_id

      t.timestamps
    end
  end
end
