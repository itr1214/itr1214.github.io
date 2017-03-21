Rails.application.routes.draw do
  get 'sessions/new'

  # get 'static_pages/home'

  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'
  get 'users/followings/:id',  to: 'users#followings'
  get 'users/followers/:id',  to: 'users#followers'
  get 'login', to: 'sessions#new'
  get 'userlist', to: 'userlist#index'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
