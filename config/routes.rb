Rails.application.routes.draw do
  devise_for :users

  resources :companies, only: [:show]

  #resources :bookings, only: [:new, :create, :destroy]

  get :select_slots, to: 'companies#select_slots'

  root 'welcome#index'
end
