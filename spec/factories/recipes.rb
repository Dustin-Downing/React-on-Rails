FactoryGirl.define do
  factory :recipe do
    name { Faker::StarWars.vehicle }
    description { Faker::StarWars.quote }
    time Random.rand(100)
  end
end
