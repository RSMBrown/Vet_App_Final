class UsersController < ApplicationController
    before_action :auth

    def index
        @users = HTTParty.get("http://127.0.0.1:3000/users", headers: {
            "Accept" => "application/json", 
            "Authorization" => cookies[:auth_token]
            })
        @vets = []
        @owners = []
        @users.each do |user|
            if user['role'] == "vet"
                @vets.push(user)
            else 
                @owners.push(user)
            end 
        end 
    end 

    def sign_up_form
    end 

    def log_in_form
    end 

    def sign_up
        @response = HTTParty.post("http://127.0.0.1:3000/signup",
            headers: {"Accept" => "application/json"}, 
            body: {
                'name' => params[:name],
                'email' => params[:email],
                'password' => params[:password],
                'password_confirmation' => params[:password_confirmation],
                'role' => params[:role]
            })
        
        cookies[:user_id] = @response['user_id']
        @user_id = @response['user_id']
        cookies[:auth_token] = @response['auth_token']

        redirect_to root_path(user_id: @user_id)
    end 

    def log_in
        @response = HTTParty.post("http://127.0.0.1:3000/auth/login",
            headers: {
                "Accept" => "application/json"
            },
            body: {
                'email' => params[:email], 
                'password' => params[:password]
            })

        if @reponse == {"message"=>"Invalid credentials"}
            redirect_to root_path
        else 
            cookies[:user_id] = @response['user_id']
            cookies[:auth_token] = @response['auth_token']
            @user_id = @response['user_id']

            redirect_to root_path(user_id: @user_id)
        end   
    end 

    private 

    def user_params
        params.permit(:name, :email, :password, :password_confirmation, :role)
    end 
end
