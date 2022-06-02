FactoryBot.define do
    factory :investment do
      amount  { Random.random_number(10..100) }
      campaign
    end
  end
  