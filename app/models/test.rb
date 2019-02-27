class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many :questions
  has_many :test_passages
  has_many :users, through: :test_passages

  scope :easy, -> { where(level: 0..2) }
  scope :middle, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }
  scope :by_category, ->(name) { category.where(categories: { title: name }) }

  validates :title, presence: true
  validates :level, numericality: { greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { scope: :level,
                                  message: 'title + level must be unique' }

  def self.titles_by_category(cat)
    by_category(cat).order(title: :desc).pluck(:title)
  end

  def questions_count
    questions.count
  end
end
