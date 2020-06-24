Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :organizations do
    resources :callees, only: %i[new create edit update destroy]
  end

  resources :callees, only: %i[index show] do
    resources :relationships, only: %i[create]
  end # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
