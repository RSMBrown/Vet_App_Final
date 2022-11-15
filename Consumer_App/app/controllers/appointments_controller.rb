class AppointmentsController < ApplicationController

    def new 
        @user_id = cookies[:user_id]
        @pet_id = cookies[:pet_id]
    end 

    def create 
        @user_id = cookies[:user_id]
        @pet_id = cookies[:pet_id]
        @response = HTTParty.post("http://127.0.0.1:3000/users/#{@user_id}/pets/#{@pet_id}/appointments", 
            headers: {
                "Accept" => "application/json", 
                "Authorization" => cookies[:auth_token]}, 
            body: {
                date: appointment_params[:date], 
                time: appointment_params[:time]
            })

        redirect_to user_pet_path(user_id: @user_id, id: @pet_id)
    end 

    def destroy 
        @user_id = cookies[:user_id]
        @pet_id = cookies[:pet_id]
        HTTParty.delete("http://127.0.0.1:3000/users/#{@user_id}/pets/#{@pet_id}", 
        headers: {
            "Accept" => "application/json", 
            "Authorization" => cookies[:auth_token]})

        redirect_to user_pet_path(user_id: @user_id, id: @pet_id)
    end 

    private 

    def appointment_params
        params.permit(:date, :time)
    end 
end
