Rails.application.routes.draw do
  
  devise_for :users
  
  devise_for :admins, controllers: {
  sessions: "admin/sessions"
  }
  
  root :to => "homes#top"
  get "home/about" => "homes#about"
  get "home/logout" => "homes#logout"
  
  resources :users,only:[:show, :edit, :update] do
    resources :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
  
  resources :groups,only:[:create, :index, :show, :edit, :update, :destroy] do
    resources :group_comments,only:[:create, :destroy]
  end
  
  # namespace :admin do
    
  # end
end
