class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true

  has_many :categories, foreign_key: 'author_id'
  has_many :expenses, foreign_key: 'author_id'
end
