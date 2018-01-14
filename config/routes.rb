Rails.application.routes.draw do
  root 'top#index'

  resources :rooms, only: [:index, :show] do
    collection { get 'search'}
  end
  resources :reservations do
    collection { post 'confirm'}
  end
  resources :plans do
    collection { post 'confirm'}
  end
  resources :sessions, only: [:create, :destroy]
  resources :members do
    collection { post 'confirm'}
  end
end
