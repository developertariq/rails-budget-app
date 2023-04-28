require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@example.com', password: 'password') }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:icon) }
    it { should belong_to(:author) }
    it { should have_many(:expenses) }
    it 'is valid with a name and an icon' do
      category = Category.new(name: 'Test', icon: fixture_file_upload('icon.png', 'image/png'), author: user)
      expect(category).to be_valid
    end
    it 'is invalid without a name' do
      category = Category.new(icon: fixture_file_upload('icon.png', 'image/png'), author: user)
      expect(category).to be_invalid
      expect(category.errors[:name]).to include("can't be blank")
    end
    it 'is invalid without an icon' do
      category = Category.new(name: 'Test', author: user)
      expect(category).to be_invalid
      expect(category.errors[:icon]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      category = Category.new(name: 'Test', icon: fixture_file_upload('icon.png', 'image/png'), author: user)
      expect(category.author).to eq(user)
    end
    it 'has many expenses' do
      category = Category.create(name: 'Test', icon: fixture_file_upload('icon.png', 'image/png'), author: user)
      expense1 = Expense.create(name: 'text expense 1', category: category, amount: 10, author: user)
      expense2 = Expense.create(name: 'text expense 2', category: category, amount: 20, author: user)
      expect(category.expenses).to eq([expense1, expense2])
    end
  end

  describe '#total_amount' do
    it 'returns the sum of expenses amount for the category' do
      category = Category.create(name: 'Test', icon: fixture_file_upload('icon.png', 'image/png'), author: user)
      Expense.create(name: 'text expense 1', category: category, amount: 10, author: user)
      Expense.create(name: 'text expense 2', category: category, amount: 20, author: user)
      expect(category.total_amount).to eq(30)
    end
  end
end
