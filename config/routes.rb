Rails.application.routes.draw do
  devise_for :users

  root "event#index"
  resources :users, only: [:show] do
    resources :pictures, only: [:create]
    resources :avatars
  end

  resources :event do
    resources :charges
    resources :attendances
    resources :avatars, only: [:create]
  end
end
