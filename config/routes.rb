Rails.application.routes.draw do
  root 'movies#index'

  get '/directors/(:director)/all_movies', to: 'movies#same_director', as: 'director_all_movies'

  resources :movies
end
