FactoryBot.define do
    factory :pet do
      name { Faker::Name.name }
      breed { Faker::Movies::HowToTrainYourDragon.dragon }
      pet_type { Faker::Games::ElderScrolls.race }
      user_id nil 
    end
  end