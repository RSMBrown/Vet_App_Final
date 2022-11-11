API
API must have an authentication system for sign up and sign in. On successful authentication, the API must respond with a token, on unsuccessful authentication, the api must respond with an error code and an error message. We will use JWT for authentication.
User should have a role column that will be either Owner or Vet
An Owner should be able to add multiple pets on the API
An Owner should be able to register their pets to a Vet
A Vet should be able to take registration of pets
An Owner should be able to schedule an appointment at a Vet
An Owner should be able send get responses that will show all their pets (and if they are registered to a vet, the name of the vet
An Owner should be able to send get responses that will show an individual ,pet, this should include the pet’s doctor (if registered), and a list of appointments for the pet (if available)
A Vet should be able to get a response of the list of pets under their care
A Vet should be able to to get a response of appointments
A Vet should be able to to get a response on an individual pet, including a list of their appointments (if available)
