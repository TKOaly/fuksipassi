Rails.application.routes.draw do
  resources :participations
  resources :events
  resources :years
  resources :participation_requests
  resources :users, only: [:show, :index]


  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'register', to: 'devise/registrations#new'
  end

  devise_for :users, :controllers => {:omniauth_callbacks => "callbacks"}
  get 'overview' => 'overview#index'

  authenticated :user do
    root :to => 'events#index', :as => :authenticated_root
  end
  root :to => redirect('login')

end
