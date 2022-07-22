Rails.application.routes.draw do
  
  devise_for :users
  root :to => "homes#top"
  get "home/about" => "homes#about"
  get "home/logout" => "homes#logout"
  
  resources :users,only:[:show, :edit, :update] #do
   #resources :relationships, only: [:create, :destroy]
   
   #get 'followings' => 'relationships#followings', as: 'followings'
   #get 'followers' => 'relationships#followers', as: 'followers'
  #end
  
  #resources :posts,only[:create, :show, :index, :edit, :update, :destroy] do
    #resources :post_comments, only: [:create, :destroy]
    #resources :favorites, only: [:create, :destroy]
  #end
  
  #resources :groups,only[:create, :index, :show, :edit, :update, :destroy] do
    #resources :group_comments,only[:create, :destroy]
  #end
  
  #devise_for :admins
  devise_for :admins, controllers: {
  sessions: "admin/sessions"
  }
end
