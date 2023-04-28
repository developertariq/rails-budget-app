require 'rails_helper'

RSpec.describe 'categories/index.html.erb', type: :feature do
  let!(:user) { User.create(name: 'test', email: 'test@example.com', password: 'password') }
  let!(:category) { Category.create(name: 'Test1', icon: fixture_file_upload('icon.png', 'image/png'), author: user) } 
  let!(:expense) { Expense.new(name: 'Test', amount: 10, author: user, category: category) }

  before do
    sign_in user    
    visit categories_path
  end

  it 'displays all categories' do 
    expect(page).to have_content(category.name)
    expect(page).to have_content("CATEGORIES")
    expect(page).to have_content("#{number_to_currency(category.total_amount)}")
  end

  it 'should show the picture for each category' do
    expect(page).to have_css('img')
  end

  it 'contains links' do
    expect(page).to have_link category.name
    expect(page).to have_link "Add new category"
  end

  it 'redirects to category payments page when clicking on a category' do 
      click_link category.name
      expect(page).to have_current_path(category_expenses_path(category))
  end

  it 'redirects to new category form when clicking on "Add new category" button' do
    click_link "Add new category"
    expect(page).to have_current_path(new_category_path)
  end
end
