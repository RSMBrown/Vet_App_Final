# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do
    user = User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password, role: 'owner')
    10.times do 
        pet = user.pets.create(name: Faker::Name.name, breed: Faker::Lorem.word, pet_type: 'dog')
        4.times do 
            pet.appointments.create(date: Faker::Date.between(from: '2014-09-23', to: '2022-09-25'), time: '09:00')
        end          
    end 
end

10.times do 
    user = User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password, role: 'vet')
end 