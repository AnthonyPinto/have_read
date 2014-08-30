HaveRead::Application.routes.draw do
  root to: 'subs#index'
  resources :users
  resource :session
  resources :subs do
    resources :posts, only: [:new, :create]
  end
  resources :posts, only: [:edit, :update, :show] do
    resources :comments, only: [:new, :create]
  end
  resources :comments, only: [:edit, :update, :destroy]
end
