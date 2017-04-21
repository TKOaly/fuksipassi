Rails.application.routes.draw do
  resources :participations
  resources :events
  resources :years
  resources :participation_requests do
    collection do
      patch 'bulk_accept',
            to: 'participation_requests#bulk_accept',
            as: :bulk_accept
    end
  end
  devise_for :users, :controllers => {:omniauth_callbacks => "callbacks"}

  scope '/apua' do
    resources :users
  end

  # get 'my_page', to: user_path


  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'register', to: 'devise/registrations#new'

  end

  get 'overview' => 'overview#index'

  authenticated :user do
    root :to => 'events#index', :as => :authenticated_root
  end
  root :to => redirect('login')

end
