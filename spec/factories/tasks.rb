FactoryBot.define do
  factory :task do
    title { "Test" }
    description { "This is a test." }
    user
  end
end