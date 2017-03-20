Rails.application.routes.draw do
  resources :participations
  resources :events
  resources :years
  devise_for :users
  root to: "home#index"
end
