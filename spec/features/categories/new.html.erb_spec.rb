require 'rails_helper'

RSpec.describe 'categories/new.html.erb', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  it 'creates a new category with a valid name and icon' do
    category = Category.new(name: 'Test Category', author: user)
    icon_path = Rails.root.join('spec', 'fixtures', 'files', 'icon.png')
    file = Rack::Test::UploadedFile.new(icon_path, 'image/png')
    category.icon = file

    expect { category.save }.to change { Category.count }.by(1)
    expect(category.name).to eq('Test Category')
    expect(category.icon.attached?).to eq(true)
  end

  it 'does not create a new category without a name' do
    category = Category.new
    icon_path = Rails.root.join('spec', 'fixtures', 'files', 'icon.png')
    file = Rack::Test::UploadedFile.new(icon_path, 'image/png')
    category.icon = file
  
    expect { category.save }.not_to change { Category.count }
    expect(category.errors[:name]).to include("can't be blank")
  end

  it 'does not create a new category without an icon' do
    category = Category.new(name: 'Test Category')
  
    expect { category.save }.not_to change { Category.count }
    expect(category.errors[:icon]).to include("can't be blank")
  end
end
