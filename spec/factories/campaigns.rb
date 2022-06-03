FactoryBot.define do
  factory :campaign do
    sequence(:name) { |n| "Campaign 1" }
    sector { %w(fintech biotech ai nanotech).sample }
    country  { FFaker::Address.country }
    percentage_raised  { 0 }
    investment_multiple { Random.random_number(10..100) }
    target_amount { Random.random_number(1000..10000000) }
  end
end
