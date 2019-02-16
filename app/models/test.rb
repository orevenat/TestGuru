class Test < ApplicationRecord
  belongs_to :category

  def self.where_category(name)
    query = 'INNER JOIN categories ON category_id = categories.id'
    Test
      .joins(query)
      .where(categories: { title: name })
      .order(title: :desc).pluck(:title)
  end
end
