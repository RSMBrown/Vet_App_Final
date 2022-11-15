class HomesController < ApplicationController
    def home 
        @user = User.find(params[:user_id])
        json_response(@user)
    end 
end 