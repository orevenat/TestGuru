class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many :questions
  has_many :tests_users
  has_many :users, through: :tests_users

  validates :title, presence: true
  validates :level, numericality: { greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { scope: :level,
                                  message: 'title + level must be unique' }

  def self.by_category(name)
    Test.joins(:category)
        .where(categories: { title: name })
        .order(title: :desc).pluck(:title)
  end
end
