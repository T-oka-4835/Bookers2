Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :books do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get root to: "homes#top"
  get "home/about" => "homes#about"
  
  # フォロー機能
  post 'follow/:id' => 'relationships#follow', as:'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as:'unfollow'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
