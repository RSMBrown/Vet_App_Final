class PetsController < ApplicationController
    before_action :auth 

    def index 
        @user = HTTParty.get("http://127.0.0.1:3000/users/#{params[:user_id]}", 
        headers: {
            "Accept" => "application/json", 
            "Authorization" => "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo2MSwiZXhwIjoxNjY4NTEwODE5fQ.RD2-URoyoGdXmCfFoWWKi4oxTG88pkBN78CV-nf7EAM"
        })
        @pets = HTTParty.get("http://127.0.0.1:3000/users/#{}/pets", 
            headers: {
                "Accept" => "application/json", 
                "Authorization" => "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo2MSwiZXhwIjoxNjY4NTEwODE5fQ.RD2-URoyoGdXmCfFoWWKi4oxTG88pkBN78CV-nf7EAM"
            })

    end 

    
end
