FactoryBot.define do
  factory :user do
    nickname { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    age { 26 }
    favorite_food { Faker::Lorem.characters(number: 10) }
  end
end
