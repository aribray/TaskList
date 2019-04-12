# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :tasks
  root to: 'tasks#index'

  # resource routing creates all of the common paths without us having to do it explicitly
  get '/tasks', to: 'tasks#index', as: 'tasks'

  get '/tasks/new', to: 'tasks#new', as: 'new_task'
  post '/tasks', to: 'tasks#create'

  get 'tasks/:id', to: 'tasks#show', as: 'task'

  get 'tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  patch '/tasks/:id', to: 'tasks#update'

  post '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'

  delete 'tasks/:id', to: 'tasks#destroy', as: 'delete_task'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
