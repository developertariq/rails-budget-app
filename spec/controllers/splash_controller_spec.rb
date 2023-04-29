require 'rails_helper'

RSpec.describe SplashController, type: :controller do
  describe 'GET #splashpage' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the splashpage template' do
      get :splashpage
      expect(response).to render_template(:splashpage)
    end
  end
end
