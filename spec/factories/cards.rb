FactoryGirl.define do
  factory :card do
    name { "Test Card" }
    multiverse_id { 42 }

    factory :invalid_card do
      name nil
    end
  end
end
