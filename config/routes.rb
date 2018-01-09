Rails.application.routes.draw do
  root 'rooms#index' # TODO:システム合体時にTOPページに変更する

  resources :rooms, only: [:index, :show] do
    collection { get 'search'}
  end
  resources :reservations do
    collection { post 'confirm'}
  end
end
