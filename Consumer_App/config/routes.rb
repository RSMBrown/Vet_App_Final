Rails.application.routes.draw do
  root 'homes#home'
  resources :users do 
    resources :pets do 
      resources :appointments 
    end 
  end 

  get '/sign_up_form', to: 'users#sign_up_form'
  post '/sign_up', to: 'users#sign_up'
  get '/log_in_form', to: 'users#log_in_form'
  post '/log_in', to: 'users#log_in'
  get '/log_out', to: 'users#log_out'
end
