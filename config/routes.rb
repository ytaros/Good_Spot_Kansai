Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html 
  # Defines the root path route ("/")
  root to: "tops#top"
  get '/main', to: 'tops#index', as: 'main_top'
end
