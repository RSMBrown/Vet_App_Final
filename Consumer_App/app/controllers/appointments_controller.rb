class AppointmentsController < ApplicationController

    def new 
        @user_id = cookies[:user_id]
        @pet_id = cookies[:pet_id]
    end 

    def create 
        auth = cookies[:auth_token]
        @user_id = cookies[:user_id]
        @pet_id = cookies[:pet_id]
        @response = AppointmentService.create_appointment(@user_id, @pet_id, params[:date], params[:time], auth)
        redirect_to user_pet_path(user_id: @user_id, id: @pet_id)
    end 
end
