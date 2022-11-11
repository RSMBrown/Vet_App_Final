Rails.application.routes.draw do
  namespace :api, url: "http://127.0.0.1:3000" do 
    root 'homes#home'
    resources :users do 
      resources :pets do 
        resources :appointments 
      end 
    end
  end  
end
