Rails.application.routes.draw do
  root 'homes#home'
  resources :users do 
    resources :pets do 
      resources :appointments
    end 
  end 
  
  post 'auth/login', to: 'authentication#authenticate'
  post '/signup', to: 'users#create'
end
