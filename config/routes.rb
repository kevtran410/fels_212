Rails.application.routes.draw do
  root "static_pages#show", page_name: "home"
  get "/pages/:page_name" => "static_pages#show", as: :page
  resources :users, only: [:new, :create]
end
