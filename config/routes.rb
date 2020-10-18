Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :books do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get root to: "homes#top"
  get "home/about" => "homes#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
