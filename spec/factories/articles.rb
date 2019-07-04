FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "The article n. #{n}" }
    sequence(:content) { |n| "The content n. #{n}" }
    sequence(:slug) { |n| "The slug n. #{n}" }
  end
end
