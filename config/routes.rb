Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :playlists, except: %i[destroy]
  resources :songs, only: %i[update]

  # Defines the root path route ("/")
  root 'playlists#index'
end
