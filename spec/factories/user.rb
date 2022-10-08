FactoryBot.define do
  factory :user do
    nickname { 'Taro' }
    sequence(:email) { |n| "test_#{n}@user.com" }
    password { 'testhoge' }
  end
end