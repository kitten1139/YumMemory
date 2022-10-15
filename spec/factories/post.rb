require 'rails_helper'

FactoryBot.define do
  factory :post do
    association :user
    association :item_category
    item_name { Faker::Lorem.characters(number:10) }
    review_title { Faker::Lorem.characters(number:10) }
    review_body { Faker::Lorem.characters(number:30) }
    rate { 1.0 }
    score { 0.9 }
  end
end