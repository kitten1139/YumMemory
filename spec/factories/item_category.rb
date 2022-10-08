FactoryBot.define do
  factory :item_category do
    association :large_category
    name { 'チョコレート' }
  end
end