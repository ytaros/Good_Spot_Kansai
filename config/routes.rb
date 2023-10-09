Rails.application.routes.draw do
  get 'articles/index'
  get 'articles/new'
  get 'articles/show'
  get 'articles/edit'
  get 'articles/create'
  get 'articles/update'
  get 'articles/destroy'
  root to: "tops#top"

  get '/main', to: 'tops#index', as: 'main_top'
  resources :users
  resources :articles
  get 'login', to: 'sessions#new'
  post 'login', to:'sessions#create'
  delete 'logout', to:'sessions#destroy'
end
