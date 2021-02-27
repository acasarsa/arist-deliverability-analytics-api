Rails.application.routes.draw do
  get 'devices/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :devices, only: [:index] 
end
