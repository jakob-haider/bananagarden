Rails.application.routes.draw do
  resources :timetickets
  get 'timeticket/index'

  resources :fields
  get 'field/index'

  resources :inventories
  resources :schedulers
  resources :gardens
  resources :bananas
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end