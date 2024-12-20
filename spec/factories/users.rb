FactoryBot.define do
  factory :user do
    email { "tdd@tdd.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
