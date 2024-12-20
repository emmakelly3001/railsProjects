# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    email { "tester@tester.com" }
    password { "password" }
    password_confirmation { "password" }  # This is important for password confirmation field
  end
end
