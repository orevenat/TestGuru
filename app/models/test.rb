class Test < ApplicationRecord
  belongs_to :category

  def self.where_category(name)
    query = "INNER JOIN categories ON category_id = categories.id " \
            "AND categories.title = '#{name}'"
    Test.joins(query).order(title: :desc).pluck(:title)
  end
end
