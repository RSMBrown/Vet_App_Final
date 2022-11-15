class PetsController < ApplicationController
    before_action :auth 

    def index 
        @user_id = cookies[:user_id]
        @user = HTTParty.get("http://127.0.0.1:3000/users/#{@user_id}", 
        headers: {
            "Accept" => "application/json", 
            "Authorization" => cookies[:auth_token]
        },
        body: {user_id: @user_id})

        @pets = HTTParty.get("http://127.0.0.1:3000/users/#{@user_id}/pets", 
            headers: {
                "Accept" => "application/json", 
                "Authorization" => cookies[:auth_token]
            })

        if @user['role'] == 'vet'
            @patients = []
            @pets = HTTParty.get("http://127.0.0.1:3000/all_pets", 
                headers: {
                    "Accept" => "application/json", 
                    "Authorization" => cookies[:auth_token]
                })
            @pets.each do |pet|
                if pet['dr'] == @user['name']
                    @patients.push(pet)
                end 
            end 
        end 
    end 

    def show 
        cookies[:pet_id] = params[:id]
        @pet_id = cookies[:pet_id]
        @user_id = cookies[:user_id]

        @pet = HTTParty.get("http://127.0.0.1:3000/users/#{@user_id}/pets/#{@pet_id}", 
        headers: {
            "Accept" => "application/json", 
            "Authorization" => cookies[:auth_token]})

        @appointments =  HTTParty.get("http://127.0.0.1:3000/users/#{@user_id}/pets/#{@pet_id}/appointments", 
                headers: {
                    "Accept" => "application/json", 
                    "Authorization" => cookies[:auth_token]})
    end 

    def new 
        @user_id = cookies[:user_id]
        @users = HTTParty.get("http://127.0.0.1:3000/users", headers: {
            "Accept" => "application/json", 
            "Authorization" => cookies[:auth_token]
            })
        @vets = []
        @users.each do |user|
            if user['role'] == "vet"
                @vets.push(user)
            end 
        end 
    end 

    def create 
        @user_id = cookies[:user_id]
        @response = HTTParty.post("http://127.0.0.1:3000/users/#{@user_id}/pets", 
        headers: {
            "Accept" => "application/json", 
            "Authorization" => cookies[:auth_token]}, 
        body: {
            user_id: pet_params[:user_id], 
            name: pet_params[:name], 
            pet_type: pet_params[:pet_type], 
            breed: pet_params[:breed],
            dr: pet_params[:dr]
        })
        @id = @response['id']

        redirect_to user_pets_path(user_id: @user_id, id: @id)
    end 

    def edit 
        @user_id = cookies[:user_id]
        @users = HTTParty.get("http://127.0.0.1:3000/users", headers: {
            "Accept" => "application/json", 
            "Authorization" => cookies[:auth_token]
            })
        @vets = []
        @users.each do |user|
            if user['role'] == "vet"
                @vets.push(user)
            end 
        end 
        cookies[:pet_id] = params[:id]
    end 

    def update 
        @user_id = cookies[:user_id]
        @pet_id = cookies[:pet_id]
        HTTParty.put("http://127.0.0.1:3000/users/#{@user_id}/pets/#{@pet_id}", 
        headers: {
            "Accept" => "application/json", 
            "Authorization" => cookies[:auth_token]}, 
        body: {
            user_id: pet_params[:user_id], 
            name: pet_params[:name], 
            pet_type: pet_params[:pet_type], 
            breed: pet_params[:breed],
            dr: pet_params[:dr]
        })

        redirect_to user_pets_path(user_id: @user_id)
    end 

    def destroy 
        @user_id = cookies[:user_id]
        @user = HTTParty.get("http://127.0.0.1:3000/users/#{@user_id}", 
            headers: {
                "Accept" => "application/json", 
                "Authorization" => cookies[:auth_token]
            })
        @id = params[:id]
        HTTParty.delete("http://127.0.0.1:3000/users/#{@user_id}/pets/#{@id}", 
        headers: {
            "Accept" => "application/json", 
            "Authorization" => cookies[:auth_token]})

        redirect_to user_pets_path(user_id: @user_id)
    end 

    private 

    def pet_params
        params.permit(:user_id, :name, :pet_type, :breed, :dr)
    end 
end
