HaveRead::Application.routes.draw do
  root to: 'subs#index'
  resources :users
  resource :session
  resources :subs do
    resources :posts, only: [:new, :create]
  end
  resources :posts, only: [:edit, :update, :show]
end
