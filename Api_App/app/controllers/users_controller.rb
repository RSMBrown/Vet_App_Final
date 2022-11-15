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

    def create
        user = User.create!(user_params)
        auth_token = AuthenticateUser.new(user.name, user.email, user.password, user.role).call
        response = { message: Message.account_created, auth_token: auth_token, user_id: user.id }
        json_response(response, :created)
    end
  
    private
  
    def user_params
        params.permit(:name, :email, :password, :password_confirmation, :role)
    end
  end