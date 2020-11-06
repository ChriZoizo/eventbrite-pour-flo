Rails.application.routes.draw do
  devise_for :users

  root "event#index"
  resources :users, only: [:show] do
    resources :pictures, only: [:create]
  end

  namespace :admin do
    root "admin#index"
    resources :event, :users
  end

  resources :event do
    resources :submission
    resources :charges
    resources :attendances
    resources :avatars, only: [:create]
  end
end
