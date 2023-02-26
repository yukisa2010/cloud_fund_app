Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/devise/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_scope :user do
    root 'devise/sessions#new'
  end

  resources :dashboards, only: :index
  resources :projects, only: %i[index show]

  namespace :admin do
    resources :projects, except: :show
  end

  namespace :users do
    resources :projects, except: %i[show]
  end
end
