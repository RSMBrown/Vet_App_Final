class AuthenticationController < ApplicationController
    skip_before_action :authorize_request, only: :authenticate
    
    def authenticate
      auth_token = AuthenticateUser.new(auth_params[:name], auth_params[:email], auth_params[:password], auth_params[:role]).call
      user = User.where(email: auth_params[:email])
      json_response(auth_token: auth_token, user_id: user.ids)
    end
  
    private
  
    def auth_params
      params.permit(:email, :password, :name, :role)
    end
end