Rails.application.routes.draw do
  resources :participations
  resources :events
  resources :years
  resources :notes
  resources :users
  resources :participation_requests do
    collection do
      patch 'accept_bulk',
            to: 'participation_requests#accept_bulk',
            as: :accept_bulk
    end
  end
  devise_for :users, :controllers => {:omniauth_callbacks => "callbacks"}

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'register', to: 'devise/registrations#new'

  end

  get 'dokaa' => 'notes#dokaa'
  get 'overview' => 'overview#index'

  authenticated :user do
    root :to => 'events#index', :as => :authenticated_root
  end
  root :to => redirect('login')

end
