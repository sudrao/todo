Todo::Application.routes.draw do
  
  resources :users

  resources :tasks
  
  root :to => 'tasks#index'
end
