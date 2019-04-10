Rails.application.routes.draw do
  resources :tasks
  
  get '/tasks', to: 'tasks#index'

  root to: 'tasks#index'

  get '/tasks/new', to: 'tasks#new'
  post '/tasks', to: 'tasks#create'

  get "tasks/:id", to: 'tasks#show'

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
