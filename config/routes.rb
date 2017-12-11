Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root to: 'devise/sessions#new'

    match '/logout' => 'devise/sessions#destroy', via: [:get, :delete]
  end

  resources :shortens

  get ':id', controller: 'shortens', action: 'show'
end
