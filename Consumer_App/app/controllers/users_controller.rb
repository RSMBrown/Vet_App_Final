class UsersController < ApplicationController

    def sign_up 
        @user = VetApi.new
    end 

    def create 
        @user = VetApi.create(user_params)

        if @user.save
            redirect_to root_path 
        else 
            render :sign_up
        end 
    end 

    def log_in
        @user = VetApi.find_by(user_params[:email])
        if @user.present? 
            redirect_to root_path(user_id: @user.id)
        else
            flash[:alert] = "Log in failed, please create an account"
        end 
    end 

    private 

    def user_params
        params.require(:user).permit(:name, :email, :password, :role)
    end 
end
