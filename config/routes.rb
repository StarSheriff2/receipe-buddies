Rails.application.routes.draw do
  root 'opinions#index'

  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :opinions, only: [:index, :create]
  resources :followings, only: [:create, :destroy]
  resources :votes, only: [:create, :destroy]

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '*all', to: 'application#index', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  } unless Rails.env.development?
end
