Rails.application.routes.draw do
  root 'static_pages#home'
  resources :assessments
  resources :exams do
    member do
      get :grade
      post :post_grades
    end
  end
  resources :attempts
  resources :standards
  resources :students
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
