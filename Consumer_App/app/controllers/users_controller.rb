class UsersController < ApplicationController
    before_action :auth
    
    def sign_up
        @response = UserService.sign_up(params[:name], params[:email], params[:password], params[:password_confirmation], params[:role])
        
        if @response['message'] == "Account created successfully"
            flash[:success] = "Sign up successful!"
            cookies[:user_id] = @response['user_id']
            @user_id = @response['user_id']
            cookies[:auth_token] = @response['auth_token']

            redirect_to root_path(user_id: @user_id)
        else 
            flash[:alert] = "Sign up failed"
            redirect_to root_path
        end 
    end 

    def log_in
        @response = UserService.log_in(params[:email], params[:password])

        if @response['auth_token'].present?
            flash[:success] = "Logged in successfully!"
            cookies[:user_id] = @response['user_id']
            cookies[:auth_token] = @response['auth_token']
            @user_id = @response['user_id']

            redirect_to root_path(user_id: @user_id)
        else 
            flash[:alert] = "Log in failed"
            redirect_to root_path
        end   
    end 

    def log_out 
        cookies[:user_id] = nil 
        cookies[:auth_token] = nil 

        redirect_to root_path
    end 
end
