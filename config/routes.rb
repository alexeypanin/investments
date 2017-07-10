Rails.application.routes.draw do
  resources :companies do
    resources :credits do
      member do
        post :add_payment
      end
    end
  end

  root 'home#index'
 end
