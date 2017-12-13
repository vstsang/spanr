Rails.application.routes.draw do
  devise_for :users

  resources :companies, only: [:show] do
    resources :bookings, except: [:index, :update]
    get :trade_view, to: 'bookings#trade_view'
  end

  # Customer booking routes
  get :select_slots, to: 'companies#select_slots'

  get :reschedule_slots, to: 'bookings#reschedule_slots'

  get :reschedule_confirm, to: 'bookings#reschedule_confirm'

  get :reschedule_save, to: 'bookings#reschedule_save'

  # Tradesman admin routes
  get :trade_slots, to: 'bookings#trade_slots'

  get :trade_booking_info, to: 'bookings#trade_booking_info'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root 'welcome#index'
end
