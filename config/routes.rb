Todo::Application.routes.draw do
  
  resources :users

  # task create/update/delete routes
  resources :tasks

  # Display only routes for pending/completed tasks
  resource :pending, :completed
    
  root :to => 'tasks#index'
end
