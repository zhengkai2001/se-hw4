Rails.application.routes.draw do
  root 'movies#index'

  get '/directors/(:director)/all_movies', to: 'movies#director_all_movies', as: 'director_all_movies'

  resources :movies
end
