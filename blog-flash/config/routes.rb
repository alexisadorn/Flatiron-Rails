Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get         'about',  to: 'static#about'
  #HTTP verb  #URL path     # Controller action - static controller, about action
end
