Rails.application.routes.draw do
  get 'student/:id/activate', to: 'students#activate', as: 'activate_student'
  resources :students, only: [:index, :show]
end
