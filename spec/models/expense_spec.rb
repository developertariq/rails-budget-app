require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@example.com', password: 'password') }
  let(:category) { Category.create(name: 'Test', icon: fixture_file_upload('icon.png', 'image/png'), author: user) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should belong_to(:author) }
    it { should belong_to(:category) }

    it 'is valid with a name, an amount, an author, and a category' do
      expense = Expense.new(name: 'Test', amount: 10, category:, author: user)
      expect(expense).to be_valid
    end

    it 'is invalid without a name' do
      expense = Expense.new(amount: 10)
      expect(expense).to be_invalid
      expect(expense.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without an amount' do
      expense = Expense.new(name: 'Test')
      expect(expense).to be_invalid
      expect(expense.errors[:amount]).to include("can't be blank")
    end

    it 'is invalid with a non-positive amount' do
      expense = Expense.new(name: 'Test', amount: 0)
      expect(expense).to be_invalid
      expect(expense.errors[:amount]).to include('must be greater than 0')
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      expense = Expense.new(name: 'Test', amount: 10, author: user, category:)
      expect(expense.author).to eq(user)
    end

    it 'belongs to a category' do
      expense = Expense.new(name: 'Test', amount: 10, author: user, category:)
      expect(expense.category).to eq(category)
    end
  end
end