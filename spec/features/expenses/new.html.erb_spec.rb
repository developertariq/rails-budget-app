require 'rails_helper'

RSpec.describe 'expenses/new.html.erb', type: :feature do
  let!(:user) { User.create(name: 'test', email: 'test@example.com', password: 'password') }
  let!(:category) { Category.create(name: 'Test1', icon: fixture_file_upload('icon.png', 'image/png'), author: user) } 
  let!(:expense) { Expense.new(name: 'Test', amount: 10, author: user, category: category) }

  it 'does not create a new category without an icon' do
    expense = Expense.new(amount: 10)
  
    expect { expense.save }.not_to change { Expense.count }
    expect(expense.errors[:name]).to include("can't be blank")
  end

  it 'does not create a new category without an icon' do
    expense = Expense.new(name: 'Test expense')
  
    expect { expense.save }.not_to change { Expense.count }
    expect(expense.errors[:amount]).to include("can't be blank")
  end
end
