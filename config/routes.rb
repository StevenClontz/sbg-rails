Rails.application.routes.draw do
  root 'static_pages#home', as: :home
  # get '/progress', to: 'static_pages#progress', as: :progress
  # get '/grades', to: 'static_pages#grades', as: :grades
  resources :courses do
    member do
      get :progress
    end

    resources :sections
    resources :grade_specifications
    resources :standard_categories
    resources :attempt_categories
    resources :students
    resources :standards
    resources :attempts do
      collection do
        get :index_recent_provisionals, layout: 'index'
        post :create_many
      end
    end

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
