Rails.application.routes.draw do
  root 'home#index'
  resources :users

  get 'dashboard', to: 'dashboard#index'
  post 'dashboard', to: 'dashboard#create'

  match 'auth/:provider/callback', to: 'sessions#create', via: :get
  delete 'session/destroy', to: 'sessions#destroy'

  mount ActionCable.server => '/cable'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
