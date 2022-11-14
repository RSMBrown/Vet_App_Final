class UsersController < ApplicationController
    before_action :auth

    def index
        @users = HTTParty.get("http://127.0.0.1:3000/users", headers: {
            "Accept" => "application/json", 
            "Authorization" => "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo2MSwiZXhwIjoxNjY4NTEwODE5fQ.RD2-URoyoGdXmCfFoWWKi4oxTG88pkBN78CV-nf7EAM"
            })
    end 

    def sign_up_form
    end 

    def log_in_form
    end 

    def sign_up
        @response = HTTParty.post("http://127.0.0.1:3000/signup",
            headers: {"Accept" => "application/json"}, 
            params => {
                'name' => params[:name],
                'email' => params[:email],
                'password' => params[:password],
                'password_confirmation' => params[:password_confirmation],
                'role' => params[:role]
            })
        @user_id = @response['user_id']
        cookies[:auth_token] = @response['authenticity_token']

        binding.pry

        redirect_to root_path(user_id: @user_id)
    end 

    def log_in
        @response = HTTParty.post("http://127.0.0.1:3000/auth/login",
            headers: {
                "Accept" => "application/json"}, 
                params => user_params)
        cookies[:auth_token] = @response['authenticity_token']
        @user_id = @response['user_id'] 

        binding.pry

        redirect_to root_path(user_id: @user.id)
    end 

    private 

    def user_params
        params.permit(:name, :email, :password, :password_confirmation, :role)
    end 
end
