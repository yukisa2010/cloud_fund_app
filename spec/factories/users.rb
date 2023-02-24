FactoryBot.define do
  factory :user, class: User do
    sequence(:email) {|n| "user-#{n}@example.com" }
    sequence(:password) {|n| "password-#{n}" }
    status { :normal }
  end
end
