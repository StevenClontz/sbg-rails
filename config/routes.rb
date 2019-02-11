Rails.application.routes.draw do
  root 'static_pages#home', as: :home
  resources :courses do
    member do
      get :progress
    end

    resources :sections
    resources :exercises do
      collection do
        get :import
        post :import, action: :create_from_import
      end
    end
    resources :assessments do
      member do
        get :print
        get "print/jared", action: :print_jared
        get "print/long", action: :print_long
        get "print/solutions", action: :solutions
      end
    end
    resources :grade_specifications
    resources :standard_categories
    resources :attempt_categories
    resources :students
    resources :standards
    resources :attempts do
      collection do
        get :index_recent_provisionals, layout: 'index'
        get :import, action: :upload
        post :import
        post :create_many
      end
    end

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
