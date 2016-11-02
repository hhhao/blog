Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get '/' => 'home#index', as: :home
  root 'home#index'
  get '/about' => 'home#about'

  #get '/posts/new' => 'posts#new', as: :new_post
  #post '/posts' => 'posts#create', as: :posts
  #get '/posts' => 'posts#index'
  #get '/posts/:id' => 'posts#show', as: :post
  #get '/posts/:id/edit' => 'posts#edit', as: :edit_post
  #patch '/posts/:id' => 'posts#update'
  #delete '/posts/:id' => 'posts#destroy'

  resources :posts, shallow: true do
    resources :comments
    resources :favourites, only: [:create, :destroy]
  end
  resources :users, only: [:edit, :update, :new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end
  resources :reset_passwords, only: [:new, :create, :edit, :update]
end
