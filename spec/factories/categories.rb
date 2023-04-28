FactoryBot.define do
  factory :category do
    name { 'foods' }
    icon { nil }
    author { association :user }
  end
end
