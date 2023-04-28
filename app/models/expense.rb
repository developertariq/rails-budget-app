class Expense < ApplicationRecord
  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  belongs_to :author, class_name: 'User'
  belongs_to :category
end
