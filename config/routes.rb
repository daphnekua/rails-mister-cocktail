Rails.application.routes.draw do
  get 'reviews/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'cocktails#index'

  resources :cocktails do
    resources :doses, except: :destroy
    resources :reviews, only: :create
  end

  resources :doses, only: :destroy
end
