Rails.application.routes.draw do
  root 'rooms#index' # TODO:システム合体時にTOPページに変更する

  resource :rooms, only: [:index, :show] do
    collection { get 'search'}
  end
end
