class Category < ApplicationRecord
  has_one_attached :icon
  validates :name, presence: true, length: { maximum: 250 }
  validates :icon, presence: true

  belongs_to :author, class_name: 'User'
  has_many :category_expenses, class_name: 'CategoryExpense', dependent: :destroy
  has_many :expenses, through: :category_expenses

  def total_amount
    expenses.sum(:amount)
  end
end
