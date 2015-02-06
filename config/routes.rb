Myflix::Application.routes.draw do
  root to: "pages#front"
  get 'home', to: "videos#index"

  get 'ui(/:action)', controller: 'ui'

  resources :videos do 
    collection do 
      post 'search', to: "videos#search"
    end
  end

  resources :categories

  get 'register', to: "users#new"
  get 'login', to: "sessions#new"
  get 'logout', to: "sessions#destroy"
  resources :users, only: [:create]
  resources :sessions, only: [:create]
end
