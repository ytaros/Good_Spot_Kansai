Rails.application.routes.draw do
  root to: "tops#top"
  get '/main', to: 'tops#index', as: 'main_top'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users, only: %i[new create]
  get 'user_articles', to: 'articles#user_articles'
  resources :areas, only: [:index] do
    get 'top', on: :collection
    resources :articles, only: %i[index new create]
  end

  resources :articles do
    collection do
      get 'search'
      get 'autocomplete'
      get 'favorites'
    end
    resources :favorites, only: %i[create destroy]
  end
  resource :profile,only: %i[show edit update destroy]
end