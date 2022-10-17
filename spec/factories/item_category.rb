FactoryBot.define do
  factory :item_category do
    association :large_category
    name { Faker::Lorem.characters(number:10) }
  end
end