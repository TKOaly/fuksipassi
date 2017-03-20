Rails.application.routes.draw do
  resources :participations
  resources :events
  resources :years
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root to: "home#index"
end
