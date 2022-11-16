class PetService

    def initialize(pet)
        @pet = pet 
    end 

    def self.all_user_pets(user_id, auth)
        @pets = HTTParty.get("http://127.0.0.1:3000/users/#{user_id}/pets", 
            headers: {
                "Accept" => "application/json", 
                "Authorization" => auth
            })
        return @pets 
    end 

    def self.all_pets(auth)
        @pets = HTTParty.get("http://127.0.0.1:3000/all_pets", 
            headers: {
                "Accept" => "application/json", 
                "Authorization" => auth
            })
        return @pets 
    end

    def self.pet(user_id, pet_id, auth)
        @pet = HTTParty.get("http://127.0.0.1:3000/users/#{user_id}/pets/#{pet_id}", 
            headers: {
                "Accept" => "application/json", 
                "Authorization" => auth})
        return @pet 
    end 

    def self.create_pet(user_id, name, pet_type, breed, dr, auth)
        @response = HTTParty.post("http://127.0.0.1:3000/users/#{user_id}/pets", 
            headers: {
                "Accept" => "application/json", 
                "Authorization" => auth}, 
            body: {
                user_id: user_id, 
                name: name, 
                pet_type: pet_type, 
                breed: breed,
                dr: dr
            })
        return @response 
    end 

    def self.update_pet(user_id, pet_id, name, pet_type, breed, dr, auth)
        HTTParty.put("http://127.0.0.1:3000/users/#{user_id}/pets/#{pet_id}", 
            headers: {
                "Accept" => "application/json", 
                "Authorization" => auth}, 
            body: {
                user_id: user_id, 
                name: name, 
                pet_type: pet_type, 
                breed: breed,
                dr: dr
            })
    end 

    def self.delete_pet(user_id, pet_id, auth)
        HTTParty.delete("http://127.0.0.1:3000/users/#{user_id}/pets/#{pet_id}", 
            headers: {
                "Accept" => "application/json", 
                "Authorization" => auth})
    end 

    def self.patients(user, pets) 
        @patients = []
        pets.each do |pet|
            if pet['dr'] == user['name']
                @patients.push(pet)
            end 
        end
        return @patients 
    end 
end 