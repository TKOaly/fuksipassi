Rails.application.routes.draw do
  resources :participations
  resources :events
  resources :years
  resources :participation_requests
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :users, only: [:show, :index]

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'register', to: 'devise/registrations#new'
  end

  get 'overview' => "overview#index"




  root to: "events#index"

end
