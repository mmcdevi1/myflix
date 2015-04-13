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
  get 'forgot_password', to: "forgot_passwords#new"
  get 'forgot_password_confirmation', to: "forgot_passwords#confirm"
  resources 'forgot_passwords', only: [:create]
  resources :users, only: [:create, :show]
  resources :sessions, only: [:create]

  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'

  get 'queue', to: "queue_items#index"
  resources :queue_items, only: [:create, :destroy]

  get 'people', to: "relationships#index"
  resources :relationships, only: [:create, :destroy]


  post 'update_queue', to: 'queue_items#update_queue'
end
