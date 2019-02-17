class Test < ApplicationRecord
  belongs_to :category

  def self.by_category(name)
    Test.joins(:category)
        .where(categories: { title: name })
        .order(title: :desc).pluck(:title)
  end
end
