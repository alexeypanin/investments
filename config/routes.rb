Rails.application.routes.draw do
  resources :companies do
    resources :credits
  end

  root 'home#index'
 end
