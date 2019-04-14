# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tasks
  root to: 'tasks#index'
  post '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
end
