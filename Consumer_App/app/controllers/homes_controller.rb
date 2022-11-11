class HomesController < ApplicationController
    def home 
        if (params[:user_id]).present?
            @user = user(:user_id)
            @name = @user.name 
        else 
            @name = "Stranger"
        end 
    end 
end
