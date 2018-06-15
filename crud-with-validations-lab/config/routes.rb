Rails.application.routes.draw do
  resources :songs
  root 'songs#index'
end
