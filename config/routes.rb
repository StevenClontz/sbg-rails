Rails.application.routes.draw do
  resources :standard_categories
  resources :courses
  root 'static_pages#home', as: :home
  # get '/progress', to: 'static_pages#progress', as: :progress
  # get '/grades', to: 'static_pages#grades', as: :grades
  resources :courses do
    member do
      get :progress
    end

    resources :standard_categories
    resources :standards
    resources :students do
      member do
        get :grade
        post :post_grades
      end
    end
    resources :attempts

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
