FactoryBot.define do
    factory :user do
      name { Faker::Games::Pokemon.name }
      email { Faker::Internet.email }
      password { Faker::Internet.password(min_length: 5, max_length: 8) } 
    end
  end