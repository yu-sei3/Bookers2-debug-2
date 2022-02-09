Rails.application.routes.draw do
  get 'rooms/new'
  get 'rooms/index'
  get 'rooms/show'
  get 'rooms/edit'
  get 'chats/show'
  get 'relationships/followings'
  get 'relationships/followed'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root to: "homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only:[:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  get '/search', to: 'searches#search'

  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  resources :rooms, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    get "join" => "rooms#join"
  end

end

