class Rule < ApplicationRecord
  has_many :badge
  validates :rule_type, presence: true
end
