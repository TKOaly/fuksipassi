Rails.application.routes.draw do
  resources :events
  resources :years
  devise_for :users
  root to: "home#index"
end
