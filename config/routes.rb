Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: 'graphql#execute'
  end
  post '/graphql', to: 'graphql#execute'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :agents, only: %i[index show create update]
  resources :properties, only: %i[index show create]
  post 'properties/:id', to: 'properties#assign', as: :assign_agent
  post 'agents/:id', to: 'agents#assign', as: :assign_property
end
