class HomesController < ApplicationController
    def home 
        @user_id = cookies[:user_id]
        auth = cookies[:auth_token]

        if @user_id.present?
            @user = UserService.user(@user_id, auth)
            @name = @user["name"] 
        else 
            @name = "Stranger"
        end 
    end 
end
