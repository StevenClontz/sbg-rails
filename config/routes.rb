Rails.application.routes.draw do
  resources :assessments
  resources :exams
  resources :attempts
  resources :standards
  resources :students
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
