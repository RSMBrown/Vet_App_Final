class PetsController < ApplicationController
    before_action :auth 

    def index 
        @pets = ApplicationController.pets(params[:user_id])
    end 

    
end
