class PetsController < ApplicationController

    def index 
        @user = User.find(params[:user_id])
        @pets = @user.pets.all
        json_response(@pets)
    end 

    def show 
        @pet = Pet.find(params[:id])
        json_response(@pet)
    end 

    def create 
        @user = User.find(params[:user_id])
        @pet = @user.pets.create!(pet_params)
        json_response(@pet, :created)
    end 

    def update 
        @pet = Pet.find(params[:id])
        @pet.update(pet_params)
        head :no_content
    end 

    def destroy 
        @pet = Pet.find(params[:id])
        @pet.destroy
        head :no_content
    end 

    private 

    def pet_params
        params.permit(:name, :pet_type, :breed)
    end 
end
