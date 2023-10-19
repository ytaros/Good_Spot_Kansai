Rails.application.routes.draw do
  get 'cities/index'
  root to: "tops#top"

  resources :areas, only: [:index] do
    resources :cities, only: [:index, :new] do
      resources :articles, only: [:index, :show, :new, :create]
    end
  end
  
  get 'areas/top', to: 'areas#top'

  get '/main', to: 'tops#index', as: 'main_top'
  resources :users
  resources :articles
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end