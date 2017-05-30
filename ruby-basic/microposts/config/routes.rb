Rails.application.routes.draw do
  get 'sessions/new'

  # get 'static_pages/home'

  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'
  get 'users/followings/:id',  to: 'users#followings'
  get 'users/followers/:id',  to: 'users#followers'
  get 'users/favorite/:id', to: 'users#favorite'
  post 'favorite', to: 'favorites#create'
  get 'login', to: 'sessions#new'
  get 'userlist', to: 'userlist#index'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'retweet', to: 'users#retweet'
  
  
  resources :users
  resources :favorite
  resources :microposts
  resources :relationships, only: [:create, :destroy]
  
end
