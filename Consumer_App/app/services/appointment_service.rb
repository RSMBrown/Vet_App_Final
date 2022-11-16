class AppointmentService
    def initialize(appointment)
        @appointment = appointment
    end 

    def self.all_appointments(user_id, pet_id, auth)
        @appointments =  HTTParty.get("http://127.0.0.1:3000/users/#{user_id}/pets/#{pet_id}/appointments", 
            headers: {
                "Accept" => "application/json", 
                "Authorization" => auth})
        return @appointments
    end 

    def self.create_appointment(user_id, pet_id, date, time, auth)
        @response = HTTParty.post("http://127.0.0.1:3000/users/#{user_id}/pets/#{pet_id}/appointments", 
            headers: {
                "Accept" => "application/json", 
                "Authorization" => auth}, 
            body: {
                date: date, 
                time: time
            })
    end 
end 