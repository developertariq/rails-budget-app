FactoryBot.define do
  factory :expense do
    name { 'mac donals' }
    amount { 17.00 }
    category { association :category }
    author { association :user }
  end
end