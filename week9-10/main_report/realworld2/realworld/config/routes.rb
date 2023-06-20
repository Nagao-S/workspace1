Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:create]
    resources :articles, only: [:create]
  end
  post '/api/users/login', to: 'api/users#login'

end
