Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :attractions do 
    resources :users
  end

  resources :users

  post '/users/new', to: 'users#create'
  get '/signin', to: 'users#signin'
  post '/signin', to: 'users#login'
  post '/logout', to: 'users#logout'
  post '/attractions/:id/ride', to: 'attractions#ride', as: 'ride'

  root 'users#new'
end
