Todo::Application.routes.draw do
  
  resource :main
  
  root :to => 'main#show'
end
