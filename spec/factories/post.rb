require 'faker'
FactoryBot.define do
  factory :post do
    content { 'this is post content' }
  end
end
