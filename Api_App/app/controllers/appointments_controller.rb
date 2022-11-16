class AppointmentsController < ApplicationController
    
    def index 
        @pet = Pet.find(params[:pet_id])
        @appointments = @pet.appointments.all
        json_response(@appointments)
    end 

    def create 
        @pet = Pet.find(params[:pet_id])
        @appointment = @pet.appointments.create!(appointment_params)
        json_response(@appointment, :created)
    end 

    private 

    def appointment_params
        params.permit(:date, :time)
    end 
end
