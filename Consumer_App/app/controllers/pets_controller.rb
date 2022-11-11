class PetsController < ApplicationController
    def index 
        @pets = find_pets
    end 

    private 

    def request_api(url)
        response = Excon.get(
            url, 
            headers: {
                'X-RapidAPI-Host' => URI.parse(url).host,
                'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
            }
        )

        return nil if response.status != 200 

        JSON.parse(response.body)
    end 

    def find_pets()
        request_api(
            "http://127.0.0.1:3000/users/:user_id/pets"
        )
    end 
end
