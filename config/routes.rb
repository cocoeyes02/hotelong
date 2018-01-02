Rails.application.routes.draw do
  root "reservations#index" # TODO:システム合体時にTOPページに変更する

  resources :reservations
end
