class UsersController < ApplicationController
    require 'rest-client'
    before_action :auth

    def sign_up_form
    end 

    def log_in_form
    end 

    def sign_up
        redirect_to root_path(user_id: @user.id)
    end 

    def log_in
        @user = request_api_log_in
        redirect_to root_path(user_id: @user.id)
    end 

    private 

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end 

    def request_api_log_in
        response = RestClient.get "http://127.0.0.1:3000/auth/login"

        return nil if response.status != 200 

        JSON.parse(response.body)
    end
end
