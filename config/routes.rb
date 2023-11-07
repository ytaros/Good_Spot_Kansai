Rails.application.routes.draw do
  root to: "tops#top"
  
  resources :areas, only: [:index] do
    get 'top', on: :collection
    resources :articles, only: [:index, :new, :create]
  end

  resources :articles do
    collection do
      get 'search'
      get 'autocomplete'
    end
  end

  get '/main', to: 'tops#index', as: 'main_top'
  resources :users
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end