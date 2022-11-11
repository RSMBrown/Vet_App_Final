class ApplicationController < ActionController::Base
    require 'rest-client'
    require 'json'

    def auth 
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo2MSwiZXhwIjoxNjY4MjUxNTMyfQ.ObX8RIgbqEUFS0TG6RcHbk5dbzlonOzKfzQgN6WlcnQ"
    end 

     

    def request_api_put(url)
        response = RestClient.put(
            url, 
            headers: {
                'Host' => URI.parse(url).host,
                'auth_token' => "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo2MSwiZXhwIjoxNjY4MjUxNTMyfQ.ObX8RIgbqEUFS0TG6RcHbk5dbzlonOzKfzQgN6WlcnQ"
            }
        )

        return nil if response.status != 200 

        JSON.parse(response.body)
    end 

    def request_api_post(url)
        response = RestClient.post(
            url, 
            headers: {
                'Host' => URI.parse(url).host,
                'auth_token' => "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo2MSwiZXhwIjoxNjY4MjUxNTMyfQ.ObX8RIgbqEUFS0TG6RcHbk5dbzlonOzKfzQgN6WlcnQ"
            }
        )

        return nil if response.status != 200 

        JSON.parse(response.body)
    end 

    def request_api_delete(url)
        response = RestClient.delete(
            url, 
            headers: {
                'Host' => URI.parse(url).host,
                'auth_token' => "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo2MSwiZXhwIjoxNjY4MjUxNTMyfQ.ObX8RIgbqEUFS0TG6RcHbk5dbzlonOzKfzQgN6WlcnQ"
            }
        )

        return nil if response.status != 200 

        JSON.parse(response.body)
    end 

    def user(user_id)
        request_api_get(
            "http://127.0.0.1:3000/users/:user_id"
        )
    end 



    def pets(user_id)
        request_api_get(
            "http://127.0.0.1:3000/users/:user_id/pets"
        )
    end 

    def pet(user_id, pet_id)
        request_api_get(
            "http://127.0.0.1:3000/users/:user_id/pets/:pet_id"
        )
    end 

    def appointments(user_id, pet_id)
        request_api_get(
            "http://127.0.0.1:3000/users/:user_id/pets/:pet_id/appointments"
        )
    end 

    def appointment(user_id, pet_id, appointment_id)
        request_api_get(
            "http://127.0.0.1:3000/users/:user_id/pets/:pet_id/appointments/:appointment_id"
        )
    end 
end
