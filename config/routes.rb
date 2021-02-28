Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do 
      post '/register', to: 'devices#register', as: 'register_device'
      post '/alive', to: 'devices#alive', as: 'heartbeat'
      post '/report', to: 'devices#report'
      patch '/terminate', to: 'devices#terminate', as: 'disable_device'
      
      ######### remove index route for production ########
      # this is here for endpoint testing in Postman 
      resources :devices, only: [:index] # remove for production 
    end
  end

end
