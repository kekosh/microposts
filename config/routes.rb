Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #課題
  # get 'users/:id/followings', to: 'users#followings'
  # get 'users/:id/followers', to: 'users#followers'
  
  #アプリケーションで使用するテーブルを指定
  resources :users do
    member do
      get :followings, :followers, :favorites
    end
  end
  resources :microposts do
    resource :favorites, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end
