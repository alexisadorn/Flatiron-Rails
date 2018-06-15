Rails.application.routes.draw do
  get '/students', to: "students#index"
end
