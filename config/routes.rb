Rails.application.routes.draw do
  resources :participations, only: [:show, :new, :edit, :create, :update, :destroy]
  resources :events
  resources :years
  resources :notes
  resources :participation_requests do
    collection do
      patch 'accept_bulk',
            to: 'participation_requests#accept_bulk',
            as: :accept_bulk
    end
  end

  devise_for :users, :controllers => {:omniauth_callbacks => "callbacks"}
  get 'users/:id', to: 'users#show', as: :user
  get 'users', to: 'users#index'
  put 'users/:id/update', to: 'users#update'
  put 'events/:event_id/hide', to: 'hidden_events#create', as: :hide_event
  delete 'events/:event_id/unhide', to: 'hidden_events#destroy', as: :unhide_event

  resources :users do
    post 'toggle_tutor', on: :member
  end


  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'register', to: 'devise/registrations#new'
  end

  get 'dokaa' => 'notes#dokaa'
  get 'overview' => 'overview#index'
  put 'change/:language', to: 'languages#change', as: :change_language

  get 'about' => 'about#index'

  authenticated :user do
    root :to => 'events#index', :as => :authenticated_root
  end
  root :to => redirect('login')

end
