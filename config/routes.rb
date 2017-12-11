Rails.application.routes.draw do
  devise_for :users

  resources :companies, only: [:show] do
    resources :bookings, except: [:index, :update]
  end

  get :select_slots, to: 'companies#select_slots'

  get :reschedule_slots, to: 'bookings#reschedule_slots'

  get :reschedule_confirm, to: 'bookings#reschedule_confirm'

  get :reschedule_save, to: 'bookings#reschedule_save'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root 'welcome#index'
end
