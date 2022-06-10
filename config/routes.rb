Rails.application.routes.draw do
  resources :playlists, except: %i[destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'playlists#index'
end
