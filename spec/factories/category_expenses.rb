FactoryBot.define do
  factory :category_expense do
    category { association :category }
    expense { association :expense }
  end
end
