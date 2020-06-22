Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

  resources :organizations do
    resources :callees, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :callees, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
