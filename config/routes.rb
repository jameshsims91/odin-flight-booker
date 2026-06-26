Rails.application.routes.draw do
  get "bookings/new"
  resources :flights, only: [ :index ]
  resources :bookings, only: [ :new, :create, :show ]
  resources :airports

  root "flights#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
