# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    email { 'test@test.com' }
    password { 'super_secret' }
    password_confirmation { 'super_secret' }
    id { 42 }
  end

  factory :deck do
    name { 'Test Deck' }
    user_id { 42 }
    legal_format { 'Modern' }
    deck_type { 'beatdown' }

    factory :invalid_deck do
      name nil
    end
  end
end
