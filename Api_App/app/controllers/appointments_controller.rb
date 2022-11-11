class AppointmentsController < ApplicationController
    before_action :authorize_request
    
    def index 
        @pet = Pet.find(params[:pet_id])
        @appointments = @pet.appointments.all
        json_response(@appointments)
    end 

    def show 
        @appointment = Appointment.find(params[:id])
        json_response(@appointment)
    end 

    def create 
        @pet = Pet.find(params[:pet_id])
        @appointment = @pet.appointments.create!(appointment_params)
        json_response(@appointment, :created)
    end 

    def update 
        @appointment = Appointment.find(params[:id])
        @appointment.update(appointment_params)
        head :no_content
    end 

    def destroy 
        @appointment = Appointment.find(params[:id])
        @appointment.destroy
        head :no_content
    end 

    private 

    def appointment_params
        params.permit(:date, :time)
    end 
end
