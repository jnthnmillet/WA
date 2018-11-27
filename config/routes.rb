Rails.application.routes.draw do
  resources :dashboards, only: :index
  resources :posts
  resources :localities
  resources :events
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions",:omniauth_callbacks => "users/omniauth_callbacks"}
  devise_scope :user do 
    authenticated :user do
      root 'dashboards#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  scope :admin do
    resources :users
  end
end
