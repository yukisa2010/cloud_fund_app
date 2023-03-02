FactoryBot.define do
  factory :project, class: Project do
    name { 'name' }
    description { 'description' }
    target_amount { 10_000 }
    user
  end
end
