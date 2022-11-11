FactoryBot.define do
    factory :appointment do
      date { Faker::Date.between(from: '2020-01-01', to: Date.today) }
      time "09:00"
      pet_id nil
    end
  end