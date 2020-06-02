require 'faker'
FactoryBot.define do
  factory :user do
    name { Faker::Name.unique }
    password { 'foobar' }
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
  end
end
