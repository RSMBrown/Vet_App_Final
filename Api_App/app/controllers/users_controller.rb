class UsersController < ApplicationController
    skip_before_action :authorize_request, only: :create

    def index
        @users = User.all
        json_response(@users)
    end 

    def show 
        @user = User.find(params[:user_id])
        json_response(@user)
    end

    def log_in
        @user = User.find_by(params[:email])
        auth_token = AuthenticateUser.new(user.name, user.email, user.password).call
        response = {user_id: @user.id, auth_token: auth_token }
        json_response(response)
    end 

    def create
        user = User.create!(user_params)
        auth_token = AuthenticateUser.new(user.name, user.email, user.password).call
        response = { message: Message.account_created, auth_token: auth_token, user_id: user.id }
        json_response(response, :created)
    end
  
    private
  
    def user_params
        params.permit(:name, :email, :password, :password_confirmation)
    end
  end