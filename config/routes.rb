Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  get '/login_form', to: 'users#login_form'
  post '/login', to: 'users#login'
  post '/users', to: 'users#create'
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: :show

  
end
