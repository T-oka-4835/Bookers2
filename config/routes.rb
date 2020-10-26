Rails.application.routes.draw do
  devise_for :users, 
  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    
    get "followings" => "relationships#followings", as: 'followings'
    get "followes" => "relationships#followers", as: 'followers'
   end
  resources :books do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get '/search' => 'searchs#search'
  get root to: "homes#top"
  get "home/about" => "homes#about"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
