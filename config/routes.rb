Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :agents, only: %i[index show create update]
  resources :properties, only: %i[index show create]
  post 'properties/:id', to: 'properties#assign', as: :assign_agent
end
