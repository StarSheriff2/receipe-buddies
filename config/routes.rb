Rails.application.routes.draw do
  root 'opinions#index'

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :opinions, only: [:index, :show, :new, :create]
  resources :followings, only: [:index, :show, :create, :destroy]

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
