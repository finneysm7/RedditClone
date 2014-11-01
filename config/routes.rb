Rails.application.routes.draw do
  root to: "sessions#new"
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:new]
  end
  
  resources :posts, except: [:new] do
    resources :comments, only: [:new]
  end
end
