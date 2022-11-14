class HomesController < ApplicationController
    def index 
        @user = User.find(params[:user_id])
        json_response(@user)
    end
end 