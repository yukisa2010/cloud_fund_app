FactoryBot.define do
  factory :investment do
    amount { 1_000 }
    user
    project
  end
end
