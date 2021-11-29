Rails.application.routes.draw do
  devise_for :users
  resources :tasks do
    patch :trigger, on: :member
    resources :notes, only: [:create], controller: 'tasks/notes'
  end
  resources :categories
  
  root to: "tasks#index"
end
