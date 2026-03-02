Rails.application.routes.draw do
  #get "search/index"
  
  resources :quote_categories
  resources :quotes
  resources :philosophers
  resources :categories
  resources :users
  #get "about/index"
  #get "home/index"
  root 'home#index'
  get '/about', to: 'about#index'
  get 'search', to: 'search#index'

  Rails.application.routes.draw do 
    # Add before or after routes already present 
    get '/admin', to: 'home#aindex'
    get '/userhome', to: 'home#uindex' 
    get '/your-quotes', to: 'home#uquotes' 
  end

  Rails.application.routes.draw do 
    # Add before or after routes already present 
    get 'login', to: 'sessions#new' 
    post 'login', to: 'sessions#create' 
    delete 'logout', to: 'sessions#destroy' 
  end 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
