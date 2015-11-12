Rails.application.routes.draw do
  root 'reviews#index'
  post 'reviews/search', to: 'reviews#search'
end
