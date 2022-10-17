FactoryBot.define do
  factory :post_comment do
    association :user
    association :post
    body { Faker::Lorem.characters(number: 10) }
  end
end