Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :agents, only: %i[index show]
  resources :properties, only: %i[index show]
end
