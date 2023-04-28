class Category < ApplicationRecord
  has_one_attached :icon
  validates :name, presence: true
  validates :icon, presence: true

  belongs_to :author, class_name: 'User'
  has_many :expenses

  def total_amount
    expenses.sum(:amount)
  end
end
