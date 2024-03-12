Rails.application.routes.draw do
  devise_for :users
  resources :books, only: [:create, :index, :edit, :update, :show, :destroy]
  resources :users, only: [:index, :show, :edit, :update]

  root to: "homes#top"
  get 'homes/about', to: 'homes#about', as: 'about'
end

