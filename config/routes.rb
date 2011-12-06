Todo::Application.routes.draw do
  
  resources :users

  # task create/update/delete routes
  resources :tasks

  root :to => 'tasks#index'
end
