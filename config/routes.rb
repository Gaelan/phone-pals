Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :organizations do
    resources :callees, only: %i[new create edit update destroy]
  end

  resources :callees, only: %i[show] do
    resources :relationships, only: %i[create]
    resources :calls, only: %i[create]
  end # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :relationships, only: %i[index new]

  get '/pages/*id' => 'pages#show', as: :page, format: false

  get 'rules' => 'rules#index'
  post 'rules/accept' => 'rules#accept'

  post 'twilio/incoming' => 'twilio#incoming'
  post 'twilio/got_code' => 'twilio#got_code'
  post 'twilio/post_call' => 'twilio#post_call'
end
