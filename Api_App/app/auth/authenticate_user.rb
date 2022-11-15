class AuthenticateUser
    def initialize(name, email, password, role)
      @name = name 
      @email = email
      @password = password
      @role = role
    end
  
    def call
      JsonWebToken.encode(user_id: user.id) if user
    end
  
    private
  
    attr_reader :email, :password, :name, :role
  
    def user
      user = User.find_by(email: email)
      return user if user && user.authenticate(password)
      raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
end