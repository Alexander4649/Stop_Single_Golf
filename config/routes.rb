Rails.application.routes.draw do
  
  devise_for :users
  
  devise_for :admins, controllers: {
  sessions: "admin/sessions"
  }
  
  root :to => "homes#top"
  get "home/about" => "homes#about"
  get "home/logout" => "homes#logout"
  
  resources :users,only:[:show, :edit, :update] do
    get 'follows' => 'relationships#follows', as: 'follows'
    get 'followers' => 'relationships#followers', as: 'followers'
    resource :relationships, only: [:create, :destroy]
  end
  
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :groups do
    get "join" => "groups#join"
    post "join" => "groups#join"
    resources :group_comments,only:[:create, :destroy]
  end
  
  # namespace :admin do
    
  # end
end
