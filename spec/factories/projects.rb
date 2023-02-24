FactoryBot.define do
  factory :project, class: Project do
    name { 'name' }
    description { 'description' }
    user
  end
end
