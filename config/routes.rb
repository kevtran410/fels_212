Rails.application.routes.draw do
  root "static_pages#show", page_name: "home"
  get "/pages/:page_name" => "static_pages#show", as: :page
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, except: :destroy
  resources :relationships, only: [:index, :create, :destroy]
  resources :categories, only: [:index, :show] do
    resources :lessons, only: [:show]
  end
  resources :lessons, only: [:create, :update]

  namespace :admin do
    resources :categories
    resources :words, only: [:create, :update, :destroy]
  end
end
