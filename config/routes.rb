Rails.application.routes.draw do
  root 'static_pages#home'
  resources :assessments
  resources :exams
  resources :attempts
  resources :standards
  resources :students
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
