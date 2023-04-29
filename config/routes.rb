Rails.application.routes.draw do
  root 'splash#splashpage'

  devise_for :users

  resources :categories, only: [:index, :new, :create] do 
    resources :expenses, only: [:index, :new, :create]
  end
end
