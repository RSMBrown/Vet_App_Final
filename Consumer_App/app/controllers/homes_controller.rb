class HomesController < ApplicationController
    def home 
        @user_id = cookies[:user_id]
        if @user_id.present?
            @user = HTTParty.get("http://127.0.0.1:3000/users/#{@user_id}", headers: {
                "Accept" => "application/json", 
                "Authorization" => cookies[:auth_token]},
            body: {user_id: @user_id})

            @name = @user["name"] 
        else 
            @name = "Stranger"
        end 
    end 

    def home_params
        params.permit(:user_id)
    end 
end
