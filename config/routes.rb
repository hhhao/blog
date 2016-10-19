Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'home#index', as: :home
  get '/about' => 'home#about'

  get '/posts/new' => 'posts#new', as: :new_post
  post '/posts' => 'posts#create', as: :posts
  get '/posts' => 'posts#index'
  get '/posts/page/:page' => 'posts#page', as: :page
  get '/posts/:id' => 'posts#show', as: :post
  get '/posts/:id/edit' => 'posts#edit', as: :edit_post
  patch '/posts/:id' => 'posts#update'
  delete '/posts/:id' => 'posts#destroy'
  post '/posts/search' => 'posts#search', as: :search_post
  get '/posts/search/:query' => 'posts#show_search', as: :show_search
end
