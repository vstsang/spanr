Rails.application.routes.draw do
  devise_for :users

  resources :companies, only: [:show] do
    resources :bookings, only: [:show, :new, :create, :destroy]
  end

  get :select_slots, to: 'companies#select_slots'

  root 'welcome#index'
end
