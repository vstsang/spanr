Rails.application.routes.draw do
  devise_for :users

  resources :companies, only: [:show]

  root 'welcome#index'
end
