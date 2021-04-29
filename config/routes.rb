Rails.application.routes.draw do
  root 'opinions#index'

  resources :users, only: [:index, :show, :new, :create]
  resources :opinions, only: [:index, :show, :new, :create]
  resources :followings, only: [:index, :show, :create, :destroy]
end
