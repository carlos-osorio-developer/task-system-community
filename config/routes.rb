Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  resources :categories
  
  root to: "tasks#index"
end
