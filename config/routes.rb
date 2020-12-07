Rails.application.routes.draw do
  mount_devise_token_auth_for "User", at: "api/auth", skip: [:omniauth_callbacks]
  namespace :api do
    resources :quotes, only: [:show, :index]
    resources :subscriptions, only: [:create]
  end
end
