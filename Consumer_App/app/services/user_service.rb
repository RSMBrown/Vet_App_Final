class UserService
    def initialize(user)
        @user = user
    end 

    def self.all_users(auth)
        @users = HTTParty.get("http://127.0.0.1:3000/users", headers: {
            "Accept" => "application/json", 
            "Authorization" => auth
            })
        return @users
    end 

    def self.user(user_id, auth)
        @user = HTTParty.get("http://127.0.0.1:3000/users/#{user_id}", 
            headers: {
                "Accept" => "application/json", 
                "Authorization" => auth
            },
            body: {user_id: user_id})
        return @user
    end

    def self.sign_up(name, email, password, password_confirmation, role)
        @response = HTTParty.post("http://127.0.0.1:3000/signup",
            headers: {"Accept" => "application/json"}, 
            body: {
                'name' => name,
                'email' => email,
                'password' => password,
                'password_confirmation' => password_confirmation,
                'role' => role
            })
        return @response 
    end 

    def self.log_in(email, password)
        @response = HTTParty.post("http://127.0.0.1:3000/auth/login",
            headers: {
                "Accept" => "application/json"
            },
            body: {
                'email' => email, 
                'password' => password
            })
        return @response
    end 

    def self.vets(users)
        vets = []
        users.each do |user|
            if user['role'] == "vet"
                vets.push(user)
            end 
        end
        return vets
    end 
end