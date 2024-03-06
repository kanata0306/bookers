Rails.application.routes.draw do
  devise_for :users
  resources :books, only: [:new, :create, :index, :show]
  resources :users, only: [:index, :show, :edit]

  root to: "homes#top"
  get 'homes/about', to: 'homes#about', as: 'about' 

end
