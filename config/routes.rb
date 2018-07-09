Rails.application.routes.draw do
  resources :dashboards, only: :index
  resources :posts
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "users/omniauth_callbacks"}
  devise_scope :user do 
    authenticated :user do
      root 'dashboards#index', as: :authenticated_root
    end

    unauthenticated do
      root 'posts#index', as: :unauthenticated_root
    end
  end
end
