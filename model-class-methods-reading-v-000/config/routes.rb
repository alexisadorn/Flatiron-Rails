Rails.application.routes.draw do

  get 'test/index'
  resources :authors, only: [:show]
  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  root 'posts#index'
end
