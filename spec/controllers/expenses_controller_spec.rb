require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  include ActionDispatch::TestProcess
  let(:user) { FactoryBot.create(:user) }
  let(:category) { Category.create(name: 'Test', icon: fixture_file_upload('icon.png', 'image/png'), author: user) }

  before do 

    sign_in user 
  end

  describe 'GET #index' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do     
      get :index, params: { category_id: category.id }
      expect(response).to render_template(:index)
    end

    it 'assigns @expenses with user expenses' do
      expense1 = FactoryBot.create(:expense, category: category, author: user) 
      expense2 = FactoryBot.create(:expense, category: category, author: user) 
      get :index, params: { category_id: category.id }
      expect(assigns(:expenses)).to eq(category.expenses)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get :new, params: { category_id: category.id }
      expect(response).to render_template(:new)
    end

    it 'assigns a new expense to @expense' do
      get :new, params: { category_id: category.id }
      expect(assigns(:expense)).to be_a_new(Expense)
    end
  end
end
