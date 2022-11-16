class PetsController < ApplicationController
    before_action :auth 

    def index 
        @user_id = cookies[:user_id]
        auth = cookies[:auth_token]
        @user = UserService.user(@user_id, auth)
        @pets = PetService.all_user_pets(@user_id, auth)

        if @user['role'] == 'vet'
            @pets = PetService.all_pets(auth)
            @patients = PetService.patients(@user, @pets)
        end 
    end 

    def show 
        cookies[:pet_id] = params[:id]
        auth = cookies[:auth_token]
        @pet_id = cookies[:pet_id]
        @user_id = cookies[:user_id]
        @user = UserService.user(@user_id, auth)
        @pet = PetService.pet(@user_id, @pet_id, auth)
        @appointments = AppointmentService.all_appointments(@user_id, @pet_id, auth)
    end 

    def new 
        @user_id = cookies[:user_id]
        @users = UserService.all_users(auth)
        @vets = UserService.vets(@users)
    end 

    def create 
        @user_id = cookies[:user_id]
        auth = cookies[:auth_token]
        @response = PetService.create_pet(@user_id, params[:name], params[:pet_type], params[:breed], params[:dr], auth)
        @pet_id = @response['id']
        redirect_to user_pets_path(user_id: @user_id, id: @pet_id)
    end 

    def edit 
        @user_id = cookies[:user_id]
        auth = cookies[:auth_token]
        @users = UserService.all_users(auth)
        @vets = UserService.vets(@users)
        cookies[:pet_id] = params[:id]
    end 

    def update 
        auth = cookies[:auth_token]
        @user_id = cookies[:user_id]
        @pet_id = cookies[:pet_id]
        PetService.update_pet(@user_id, @pet_id, params[:name], params[:pet_type], params[:breed], params[:dr], auth)

        redirect_to user_pets_path(user_id: @user_id)
    end 

    def destroy 
        auth = cookies[:auth_token]
        @user_id = cookies[:user_id]
        @pet_id = params[:id]
        PetService.delete_pet(@user_id, @pet_id, auth)

        redirect_to user_pets_path(user_id: @user_id)
    end 
end
