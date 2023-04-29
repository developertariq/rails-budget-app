class Expense < ApplicationRecord
  validates :name, presence: true, length: { maximum: 250 }
  validates :amount, presence: true, numericality: { greater_than: 0 }

  belongs_to :author, class_name: 'User'

  has_many :category_expenses, class_name: 'CategoryExpense', dependent: :destroy
  has_many :categories, through: :category_expenses, dependent: :destroy
end
