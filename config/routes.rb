Rails.application.routes.draw do
  
  devise_for :users
  #   ,controllers: {
  #   registrations: 'users/registrations',
  #   passwords: 'users/passwords'
  # }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  #管理者機能が少ない為、今回は使用しないこととする。
  #仕様変更できる様に、コメントアウトとする。
  # devise_for :admins, controllers: {
  # sessions: "admin/sessions"
  # }
  root :to => "homes#top"
  get "home/about" => "homes#about"
  get "home/logout" => "homes#logout"
  get "search" => "searches#search"
  get 'chat/:user_id' => 'chats#show', as: 'chat'
  delete 'rooms/:room_id/chat_destroy/:id' => 'chats#destroy', as: 'chat_destroy'
  post 'rooms/:room_id/chats' => 'chats#create', as: 'chat_create'
  
  resources :notifications, only: :index do
    collection do
    delete  "destroy_all" => "notifications#destroy_all"
    end
  end
  
  resources :users,only:[:show, :index, :edit, :update, :destroy] do
    get "search_form" => "users#search_form"
    get 'follows' => 'relationships#follows', as: 'follows'
    get 'followers' => 'relationships#followers', as: 'followers'
    resource :relationships, only: [:create, :destroy]
  end
  
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    get "bookmarks" => "bookmarks#index"
    resource :bookmarks, only: [:create, :destroy]
    
    collection do
    get 'confirm'
    end
  end
  
  resources :groups do
    get "join" => "groups#join"
    post "join" => "groups#join"
    delete "out" => "groups#out"
    resources :group_comments,only:[:create, :destroy]
  end
end
