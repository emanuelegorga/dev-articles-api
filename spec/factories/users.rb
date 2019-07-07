FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "emanuele #{n}" }
    name { "Emanuele" }
    url { "http://example.com" }
    avatar_url { "http://example.com/avatar" }
    provider { "github" }
  end
end
