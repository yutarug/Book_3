Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "/home/about"=> "homes#about"
  get "search" => "searches#index"
  resources :users do
  	get "/follows" => "users#follows"
  	get "/followers" => "users#followers"
  end
  resources :books do
  	resource :favorites, only:[:create, :destroy]
  	resource :post_comments, only: [:create, :destroy]
  end
   resources :relationships, only: [:create, :destroy]
end
