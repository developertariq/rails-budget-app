require 'rails_helper'

RSpec.describe 'expenses/index.html.erb', type: :feature do
  let!(:user) { User.create(name: 'test', email: 'test@example.com', password: 'password') }
  let!(:category) { Category.create(name: 'Test1', icon: fixture_file_upload('icon.png', 'image/png'), author: user) }
  let!(:expense) { Expense.new(name: 'Test', amount: 10, author: user, category:) }

  before do
    sign_in user
    visit category_expenses_path(category)
  end

  it 'displays the category name and total amount' do
    expect(page).to have_content(category.name)
    expect(page).to have_content(number_to_currency(category.total_amount).to_s)
  end

  it 'displays the correct expenses for the category' do
    expect(page).to have_content(expense.name)
    expect(page).to have_content('TRANSACTIONS')
  end

  it 'contains links' do
    expect(page).to have_link 'Add new transaction'
  end

  it 'takes you to the new expense page' do
    click_link 'Add new transaction'
    expect(page).to have_current_path(new_category_expense_path(category))
  end
end
