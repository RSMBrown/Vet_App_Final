class HomesController < ApplicationController
    def home 
        if (params[:user_id]).present?
            @user = HTTParty.get("http://127.0.0.1:3000/", headers: {
                "Accept" => "application/json", 
                })
            @name = @user["name"] 
        else 
            @name = "Stranger"
        end 
    end 
end
