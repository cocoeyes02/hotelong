Rails.application.routes.draw do
  root 'top#index'

  resources :rooms, only: [:index, :show] do
    collection { get 'search'}
  end
  resources :reservations do
    collection { post 'confirm'}
  end
  resources :plans, only: [:index] do
    collection { post 'confirm'}
  end
  resource :session, only: [:create, :destroy]
  resources :members do
    collection { post 'confirm'}
  end

  namespace :admin do
    root to: 'top#index'
    resources :members, except: [:new, :create]
    resources :reservations, except: [:new, :create]
    resources :plans
  end

  resources :mypage, only: [:index]
end
