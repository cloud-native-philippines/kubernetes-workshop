Rails.application.routes.draw do
  resources :tweets

  root to: 'tweets#index'
end
