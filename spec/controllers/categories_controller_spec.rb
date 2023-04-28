require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:category1) { FactoryBot.create(:category, author: user) }
  let(:category2) { FactoryBot.create(:category, author: user) }

  before do 
    user.save
    sign_in user 
  end

  describe 'GET #index' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @categories with user categories' do
      get :index
      expect(assigns(:categories)).to eq(user.categories)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new category to @category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end
end
