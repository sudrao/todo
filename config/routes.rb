Todo::Application.routes.draw do
  
  resources :users

  resources :tasks

  resource :main
  
  root :to => 'main#show'
end
