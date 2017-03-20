Rails.application.routes.draw do
  resources :participations
  resources :events
  resources :years
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
  end


  root to: "events#index"

end
