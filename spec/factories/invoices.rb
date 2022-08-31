FactoryBot.define do
  factory :invoice do
    status { "completed" }
    customer
    merchant
  end
end
