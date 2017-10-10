FactoryGirl.define do
  factory :ingredient do
    name { Faker::StarWars.planet }
    amount { Faker::StarWars.specie }
    recipe_id nil
  end
end
