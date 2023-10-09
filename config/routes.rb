Rails.application.routes.draw do
  root to: "tops#top"

  get '/main', to: 'tops#index', as: 'main_top'
  resources :users
  get 'login', to: 'sessions#new'
  post 'login', to:'sessions#create'
  delete 'logout', to:'sessions#destroy'
end
