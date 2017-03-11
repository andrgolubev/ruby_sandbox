Rails.application.routes.draw do
  root to: 'articles#index'

  resources :articles do
    resources :comments
  end

  resources :tags

  resources :authors

  resource :author_sessions, only: [:new, :create, :destroy]
  get 'login' => 'author_sessions#new'
  get 'logout' => 'author_sessions#destroy'
  get 'logon' => 'authors#new'
end
