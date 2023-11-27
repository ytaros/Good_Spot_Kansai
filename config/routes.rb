Rails.application.routes.draw do
  root to: "tops#top"
  get '/main', to: 'tops#index', as: 'main_top'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'privacy_policy', to: 'tops#privacy_policy'
  get 'terms_of_service', to: 'tops#terms_of_service'

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
  resources :password_resets, only: %i[new create edit update]
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  resource :profile,only: %i[show edit update destroy]
end