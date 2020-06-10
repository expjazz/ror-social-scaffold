Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users
  get 'search_user', to: 'users#search'

  resources :users, only: %i[index show] do
    # post '/users', to: 'friendships#create'
    resources :friendships, only: %i[create update destroy]
  end
  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
