Rails.application.routes.draw do
  root 'home#landing'

  devise_for :users

  resources :users do
    resources :tasks
  end
end
