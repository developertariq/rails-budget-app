Rails.application.routes.draw do
  root 'splash#splashpage'

  devise_for :users

  resources :categories do 
    resources :expenses 
  end
end
