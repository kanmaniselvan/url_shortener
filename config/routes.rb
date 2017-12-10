Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :shortens, only: [:index, :create, :show]

  map.connect ':id', controller: 'shortens', action: 'show'
end
