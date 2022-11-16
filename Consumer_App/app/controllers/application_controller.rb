class ApplicationController < ActionController::Base
    require 'json'


    def auth 
        cookies[:auth_token]
    end 

end 

   
