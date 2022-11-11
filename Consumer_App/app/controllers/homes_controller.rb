class HomesController < ApplicationController
    def home 
        if (params[:user_id]).present?
            @user = VetApi.find_by(params[:user_id])
            @name = @user.name 
        else 
            @name = "Stranger"
        end 
    end 
end
