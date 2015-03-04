Myflix::Application.routes.draw do
  root to: "pages#front"
  get 'home', to: "videos#index"

  get 'ui(/:action)', controller: 'ui'

  resources :videos do 
    collection do 
      post 'search', to: "videos#search"
    end

    resources :reviews,  only: :create
    resources :review2s, only: :create
  end

  resources :categories

  get 'register', to: "users#new"
  get 'login', to: "sessions#new"
  get 'logout', to: "sessions#destroy"
  resources :users, only: [:create]
  resources :sessions, only: [:create]

  get 'queue', to: "queue_items#index"
  resources :queue_items, only: [:create, :destroy]

  post 'update_queue', to: 'queue_items#update_queue'
end
