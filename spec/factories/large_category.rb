FactoryBot.define do
  factory :large_category do
    name { Faker::Lorem.characters(number:10) }
  end
end