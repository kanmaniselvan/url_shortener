Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :shortens, only: [:index, :create, :show]

  get ':id', controller: 'shortens', action: 'show'
end
