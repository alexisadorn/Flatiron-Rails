Rails.application.routes.draw do
  get 'authors/show'

  get 'test/index'

  resources :posts, only: [:index, :show, :new, :create, :edit, :update]
end