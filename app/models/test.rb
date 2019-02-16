class Test < ApplicationRecord
  belongs_to :category

  def self.where_category(name)
    category_id = Category.find_by(title: name).id

    Test.where(category_id: category_id).order(title: :DESC)
  end
end
